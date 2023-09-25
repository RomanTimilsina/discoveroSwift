//
//  LoginVCViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//

import UIKit
import os

class LoginVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = LoginView()
    var isFromLogin: Bool?
    lazy var countryPicker = DIPickerVC()
//    let newcountryModel = [NewCountryModel]()
    var newCountryModel = countryManager()
    
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        observeViewEvents()
        APICall()
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = {[weak self] in
            guard let self else {return}
            navigationController?.popViewController(animated: true)
        }
        
        currentView.handleConfirmOTP = {[weak self] in
            guard let self = self, let isFromLogin = isFromLogin else {return}
            self.gotoOTPConfirmV(isFromLogin: isFromLogin)
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
        if let country: [CountryModel] = Bundle.main.decode(from: "Countries.json") {
//            print(country[0].name, country[0].dialCode, country[0].code)
            
            
            for (index ,number ) in country.enumerated() {
                let name = country[index].code.lowercased()
                if let image = UIImage(named: name) {
                    newCountryModel.setData(name: country[index].name, dialCode: country[index].dialCode, code: country[index].code, imageName: country[index].code)
                }
            }
        } else {
            print("Failed to load and decode the JSON file.")
        }
        
        
        countryPicker.countryModel = newCountryModel.getData()
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
//            print("P")
        present(countryPicker, animated: true)
      
    }
    
   
    private func gotoOTPConfirmV(isFromLogin: Bool) {
        let otpConfirmVC = OTPConfirmVC()
        otpConfirmVC.isFromLogin = isFromLogin
        navigationController?.pushViewController(otpConfirmVC, animated: true)
    }
}

extension LoginVC {
    func APICall() {
        if let url = URL(string: "https://pro.ip-api.com/json/?key=xylJvTwPTjbRGfQ&fbclid=IwAR32KyySS9xuWC3BQzE3VCO9rTft6-E4yFNsPbKKDOfUZPwS-wtTvkErTgY") {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error: \(error)")
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
                                    }
                                } catch {
                                    print("Error encoding locationInfo: \(error)")
                                }
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

