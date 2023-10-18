//
//  LocationFilterVC.swift
//  Discovero
//
//  Created by Mac on 12/10/2023.
//

import UIKit

class LocationFilterVC: UIViewController {
    
    var onLocationStateChange: ((String, String, String) -> Void)?
    
    lazy var countryPicker = DIPickerVC()
    var currentView = LocationFilterView()
    var userData: UserData?
    var firestore = FireStoreDatabaseHelper()
    var countryManager = CountryManager()
    var newCountryModel = CountryManager()
    var countryList: [CountryStateModel] = []
    var selectedCountyList: [String] = []
    var selectedCountryName = ""
    var run = true
    let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesAndState()
        
        currentView.suburbTextField.delegate = self
        currentView.countriesTextField.text = userData?.country
        currentView.statesTextField.text = userData?.locationDetail.state
        
        countryPicker.countryModel = countryManager.getData()
        
        observeViewEvents()
    }
    
    func countriesAndState() {
        firestore.getCountryWithState() { [weak self] countriesAndStates in
            guard let self else { return }
            for countryAndStates in countriesAndStates {
                debugPrint(countryAndStates.name)
                
                
                for (index,_) in countries.enumerated() {
                    if countries[index].name == countryAndStates.name {
                        countryList.append(countryAndStates)
//                        loadMenu()
                        let name = countries[index].code.lowercased()
                        if UIImage(named: name) != nil {
                            
                            if selectedCountryName == countryAndStates.name {
                                //                                selectedCountryName = userData?.country ?? ""
                                //                                currentView.stateTFCoverButton.menu = addInfoMenu(selectedCountryName)
                            }
                            loadMenu()
                            newCountryModel.setData(name: countries[index].name, dialCode: countries[index].dialCode, code: countries[index].code, imageName: countries[index].code)
                        }
                    }
                }
            }
        }
    }
    
    func loadMenu() {
        if selectedCountryName == "" {
            selectedCountryName = userData?.country ?? ""
            currentView.stateTFCoverButton.menu = addStateMenu(userData?.country ?? "")
            //            run = false
        }
    }
    
    override func loadView() {
        view = currentView
        navigationController?.navigationBar.isHidden = true
    }
    
    func observeViewEvents() {
        currentView.countriesTap = { [weak self] in
            guard let self else { return }
            
            openCountryPicker()
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        countryPicker.onClosePicker = { [weak self] in
            guard let self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        countryPicker.onPicked = { [weak self] model in
            guard let self = self else { return }
            debugPrint(model.name)
            selectedCountryName = model.name
            countriesAndState()
            currentView.countriesTextField.text = model.name
            
            currentView.statesTextField.text = ""
            
            currentView.stateTFCoverButton.menu = addStateMenu(selectedCountryName)
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.handleSave = { [weak self] country, state, suburb in
            guard let self else { return }
            onLocationStateChange?(country, state, suburb)
            navigationController?.popViewController(animated: true)
        }
        
        currentView.stateTap = { [weak self] in
            guard let self else { return }
            
            loadMenu()
        }
    }
    
    private func addStateMenu(_ CountryName: String) -> UIMenu {
        
        var menuList = [UIMenuElement]()
        for country in countryList {
            if CountryName == country.name {
                let states = UIAction(title: country.state[0].name, handler: { _ in
                    self.currentView.statesTextField.text = country.state[0].name
                })
                menuList.append(states)
                selectedCountyList.append(CountryName)
            }
        }
        countryList = []
        
        let infoMenu = UIMenu(title: "", children: menuList)
        return infoMenu
    }
    
    func resetStateMenu() {
        currentView.stateTFCoverButton.menu = addStateMenu(userData?.country ?? "")
    }
}

// MARK: Textfield delegates
extension LocationFilterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == currentView.suburbTextField {
            currentView.lineview3.backgroundColor = Color.primary
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == currentView.suburbTextField {
            currentView.lineview3.backgroundColor = Color.gray400
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension LocationFilterVC: UISheetPresentationControllerDelegate {
    func openCountryPicker() {
        countryPicker.modalPresentationStyle = .fullScreen
        countryPicker.countryModel = newCountryModel.getData()
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        countryPicker.pickerView.searchBar.textFieldAttribute(placeholderText: "Search for Nation", placeholderHeight: 14)
        present(countryPicker, animated: true)
    }

}


