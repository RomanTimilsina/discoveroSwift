//
//  LoginVCViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

class LoginVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = LoginView()
    var isFromLogin: Bool?
    lazy var countryPicker = DIPickerVC()
    var newCountryModel = CountryManager()
    let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        observeViewEvents()
        apiCall(completion: { [weak self] locationModel in
            guard let self else {return}
            currentView.phoneNumberTextField.countryCodeLabel.text = findExtensionCode(for: locationModel?.countryCode ?? "")
        })
        setupNewCountryModel()
    }
    
    func setupNewCountryModel() {
        for (index,_) in countries.enumerated() {
            let name = countries[index].code.lowercased()
            if let image = UIImage(named: name) {
                newCountryModel.setData(name: countries[index].name, dialCode: countries[index].dialCode, code: countries[index].code, imageName: countries[index].code)
            }
        }
    }
    
    func findExtensionCode(for countryCode: String) -> String? {
        if let country = countries.first(where: { $0.code == countryCode }) {
            return country.dialCode
        } else {
            return nil // Country code not found in the array
        }
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = {[weak self] in
            guard let self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onNextClick = {[weak self] phoneNum in
            guard let self = self else {return}
            showHUD()
            gotoOTPConfirmV(isFromLogin: isFromLogin ?? false, phoneNum: phoneNum)
        }
        
        countryPicker.closePicker = {[weak self] in
            guard let self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        currentView.phoneNumberTextField.handleCountryCode  = {[weak self] in
            guard let self else {return}
            openCountryPicker()
        }
        
        countryPicker.onPicked = {[weak self] model in
            guard let self = self else {return}
            currentView.phoneNumberTextField.countryCodeLabel.text = model.dialCode
        }
    }
    
    func openCountryPicker() {
        countryPicker.countryModel = newCountryModel.getData()
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        present(countryPicker, animated: true)
    }
    
    private func gotoOTPConfirmV(isFromLogin: Bool, phoneNum: String) {
        let phoneNumber = "\(currentView.phoneNumberTextField.countryCodeLabel.text ?? "")\(phoneNum)"
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("Error: ", error.localizedDescription)
                    // show alert
                    return
                }
                self.hideHUD()
                let otpConfirmVC = OTPConfirmVC()
                otpConfirmVC.verificationId = verificationID
                self.navigationController?.pushViewController(otpConfirmVC, animated: true)
            }
    }
}

extension LoginVC {
    func apiCall(completion: @escaping (LocationModel?) -> Void) {
        if let url = URL(string: "https://pro.ip-api.com/json/?key=xylJvTwPTjbRGfQ&fbclid=IwAR32KyySS9xuWC3BQzE3VCO9rTft6-E4yFNsPbKKDOfUZPwS-wtTvkErTgY") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let city = json["city"] as? String,
                               let country = json["country"] as? String,
                               let countryCode = json["countryCode"] as? String,
                               let lat = json["lat"] as? Double,
                               let lon = json["lon"] as? Double {
                                let locationInfo = LocationModel(city: city, country: country, countryCode: countryCode, lat: lat, lon: lon)
                                
                                let userDefaults = UserDefaults.standard
                                
                                do {
                                    let encodedData = try JSONEncoder().encode(locationInfo)
                                    userDefaults.set(encodedData, forKey: "locationInfo")
                                    DispatchQueue.main.async {
                                        print(locationInfo)
                                        completion(locationInfo)
                                    }
                                } catch {
                                    print("Error encoding locationInfo: \(error)")
                                    completion(nil)
                                }
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
}
