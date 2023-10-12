//
//  LocationFilterVC.swift
//  Discovero
//
//  Created by Mac on 12/10/2023.
//

import UIKit

class LocationFilterVC: UIViewController, UITextFieldDelegate, UISheetPresentationControllerDelegate {
    
    lazy var countryPicker = DIPickerVC()
    var currentView = LocationFilterView()
    var userData: UserData?
    var firestore = FireStoreDatabaseHelper()
    var countryManager = CountryManager()
    var selectedLanguage: String?
    var isSelected: Bool?
    var newCountryModel = CountryManager()
    
    let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesAndState()
        
        currentView.suburbTextField.delegate = self
        currentView.countriesTextField.text = userData?.country
        currentView.statesTextField.text = userData?.locationDetail.state
        
        setupNewCountryModel()
        print(countryManager.getData())
        countryPicker.countryModel = countryManager.getData()
        observeViewEvents()
    }
    
    func countriesAndState() {
        firestore.getCountryWithState() { [weak self] countriesAndStates in
            guard let self else { return }
            for countryAndStates in countriesAndStates {
                print(countryAndStates.name)
                
                for (index,_) in countries.enumerated() {
                    if countries[index].name == countryAndStates.name {
                        let name = countries[index].code.lowercased()
                        if let image = UIImage(named: name) {
                            newCountryModel.setData(name: countries[index].name, dialCode: countries[index].dialCode, code: countries[index].code, imageName: countries[index].code)
                        }
                    }
                }
//                                countryManager.setsData(name: <#T##String#>, dialCode: <#T##String#>, code: <#T##String#>, imageName: <#T##String#>)
            }
        }
    }
    
    func setupNewCountryModel() {

    }
    
    override func loadView() {
        view = currentView
//        navigationController?.navigationBar.isHidden = true
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
        
        countryPicker.closePicker = { [weak self] in
            guard let self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        countryPicker.onPicked = { [weak self] model in
            guard let self = self else { return }
            currentView.countriesTextField.text = model.name
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
    }
    
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
    
    func setCountry() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
//            countryManager.setData(name: <#T##String#>, dialCode: <#T##String#>, code: <#T##String#>, imageName: <#T##String#>)
        }
    }
    
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
    
//    func openCountryPicker() {
//        countryPicker.modalPresentationStyle = .fullScreen
////        countryPicker.pickerView.searchBar.searchField.text = ""
//        if let sheet = countryPicker.sheetPresentationController {
//            
//            sheet.prefersGrabberVisible = true
//            sheet.preferredCornerRadius = 30
//            sheet.detents = [.large()]
//            sheet.delegate = self
//        }
//        
//        countryPicker.isRegistration = true
//        countryPicker.pickerView.searchBar.textFieldAttribute(placeholderText: "", placeholderHeight: 14)
//        present(countryPicker, animated: true)
//        
////        currentView.languagePickerTextField.textField.placeholder = ""
//        countryPicker.sendSavedData = { [weak self] selectedLanguages in
//            self?.selectedLanguage = ""
//            guard let self = self else { return }
//            for (index, languages) in selectedLanguages.enumerated() {
//                self.selectedLanguage! +=  index == 0 ? "\(languages)" : ", \(languages)"
//            }
//            
//            isSelected = true
//            if selectedLanguages.isEmpty == true {
//                isSelected = false
//                self.currentView.countriesTextField.placeholder = "Tap here to choose"
//                self.currentView.countriesTextField.text =  ""
//            } else {
//                self.currentView.countriesTextField.placeholder = ""
//                self.currentView.countriesTextField.text =  self.selectedLanguage
//            }
//        }
//    }

}



