//
//  PersonalInfoVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit
import FirebaseFirestore

class RegistrationVC: UIViewController {
    
    let currentView = RegistrationView()
    
    lazy var countryPicker = DIPickerVC()
    var languageManager = LanguageManager()
    var hasName: Bool?
    var isSelected: Bool?
    var selectedLanguage: String?
    let phoneNumber: String
    let userId: String
    
    init(phoneNumber: String, userId: String) {
        self.phoneNumber = phoneNumber
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        currentView.personalInfoTextField.textField.delegate = self
        setLanguage()
        
        countryPicker.languageModel = languageManager.getData()
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.openPicker = { [weak self] in
            guard let self = self else { return }
            openCountryPicker()
        }
        
        countryPicker.onClosePicker = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        currentView.onSignUp = { [weak self] nameText in
            guard let self = self else { return }
            saveRegisterData()
        }
        
        countryPicker.onCountryPicked = { [weak self] model in
            guard let self = self else { return }
            currentView.languagePickerTextField.textField.placeholder = ""
            currentView.languagePickerTextField.textField.text = model.name
            currentView.languagePickerTextField.flagImageView.image = model.flagImage
            isSelected = true
            if let isSelected, let hasName {
                if isSelected && hasName {
                    currentView.signUpButton.setValidState()
                } else {
                    currentView.signUpButton.setInvalidState()
                }
            }
        }
    }
    
    override func loadView() {
        view = currentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TextField Delegates
extension RegistrationVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === currentView.languagePickerTextField.textField {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === currentView.personalInfoTextField.textField {
            guard let text = textField.text else { return }
            if !text.isEmpty {
                hasName = true
            }
            else {
                hasName = false
            }
        }
        
        guard let isSelected = isSelected , let hasName = self.hasName else { return }
        if isSelected && hasName {
            currentView.signUpButton.setValidState()
        } else {
            currentView.signUpButton.setInvalidState()
        }
    }
}

// MARK: - Nav function
extension RegistrationVC {
    private func gotoWelcomePageVC(nameText: String) {
        let welcomeVC = WelcomeVC()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}

// MARK: - save user to userDefaults
extension RegistrationVC {
    private func saveRegisterData() {
        showHUD()
        
        let database = Firestore.firestore()
        let userDefaults = UserDefaults.standard
        
        let languages = selectedLanguage?.components(separatedBy: ",") ?? []
        if let locationData = userDefaults.data(forKey: "locationInfo") {
            do {
                let decoder = JSONDecoder()
                let location = try decoder.decode(LocationModel.self, from: locationData)
                let data = [
                    "country": location.country,
                    "countryCode": location.countryCode,
                    "dialCode": findExtensionCode(for: location.countryCode) ?? "",
                    "displayLocation": location.city,
                    "languages": languages,
                    "locationDetail": [
                        "buildingNo": "",
                        "country": location.country,
                        "state": location.regionName,
                        "streetName": "",
                        "streetNo": "",
                        "suburb": location.regionName,
                    ],
                    "name": currentView.personalInfoTextField.textField.text ?? "",
                    "phoneNumber": phoneNumber,
                    "uid": userId
                ] as [String : Any]
                
                database.collection("Users").addDocument(data: data) { [weak self] error in
                    guard let self = self else { return }
                    hideHUD()
                    if let error = error {
                        AlertMessage.showBasicAlert(on: self, message: error.localizedDescription)
                    } else {
                        print("success")
                        UserDefaultsHelper.setStringData(value: "set", key: .isLoggedIn)
                        UserDefaultsHelper.setStringData(value: userId, key: .userId)
                        gotoWelcomePageVC(nameText: currentView.personalInfoTextField.textField.text ?? "")
                    }
                }
            } catch let error {
                hideHUD()
                print("Unable to Decode (\(error))")
            }
        } else {
            hideHUD()
            print("Error to decode location data")
        }
    }
}

//MARK: UISheet
extension RegistrationVC: UISheetPresentationControllerDelegate {
    func openCountryPicker() {
        countryPicker.modalPresentationStyle = .fullScreen
        //        countryPicker.pickerView.searchBar.searchField.text = ""
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        
        countryPicker.isRegistration = true
        countryPicker.currentView.searchBar.textFieldAttribute(placeholderText: "Search for Language", placeholderHeight: 14)
        present(countryPicker, animated: true)
        //        currentView.languagePickerTextField.textField.placeholder = ""
        countryPicker.sendSavedData = { [weak self] selectedLanguages in
            self?.selectedLanguage = ""
            guard let self = self else { return }
            for (index, languages) in selectedLanguages.enumerated() {
                self.selectedLanguage! +=  index == 0 ? "\(languages)" : ", \(languages)"
            }
            
            isSelected = true
            if selectedLanguages.isEmpty == true {
                isSelected = false
                self.currentView.languagePickerTextField.textField.placeholder = "Tap here to choose"
                self.currentView.languagePickerTextField.textField.text =  ""
            } else {
                self.currentView.languagePickerTextField.textField.placeholder = ""
                self.currentView.languagePickerTextField.textField.text =  self.selectedLanguage
            }
            
            if let isSelected, let hasName {
                if isSelected && hasName {
                    currentView.signUpButton.setValidState()
                } else {
                    currentView.signUpButton.setInvalidState()
                }
            }
        }
    }
}

//MARK: Language and extension code
extension RegistrationVC {
    func findExtensionCode(for countryCode: String) -> String? {
        let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
        if let country = countries.first(where: { $0.code == countryCode }) {
            return country.dialCode
        } else {
            return nil // Country code not found in the array
        }
    }
    
    func setLanguage() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
            languageManager.setData(language: language, isSelected: false)
        }
    }
}
