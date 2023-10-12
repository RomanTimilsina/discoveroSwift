//
//  FilterVC.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit

class FilterSelectorVC: UIViewController, UISheetPresentationControllerDelegate, UIEditMenuInteractionDelegate {

    let currentView = FilterSelectorView()
    lazy var countryPicker = DIPickerVC()
    var languageManager = LanguageManager()
    var selectedLanguage: String?
    lazy var languages = languageManager.getData()
    var firestore = FireStoreDatabaseHelper()
    var languageArray: [String] = []
    var usersData: UserData?
    var location = ""
    var editMenuInteraction: UIEditMenuInteraction?

    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
        navigationController?.navigationBar.isHidden = true
//----------------------------------------
//        editMenuInteraction = UIEditMenuInteraction(delegate: self)
//        guard let editMenuInteraction else { return }
//        currentView.propertyTypeLabel.mainStack.addInteraction(editMenuInteraction)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
//    currentView.propertyTypeLabel.mainStack.addGestureRecognizer(tap)
  //----------------------------------------
        // Create the gesture recognizer.

        
//        editMenuInteraction = UIEditMenuInteraction(delegate: self)
//
//           interactionView.addInteraction(editMenuInteraction!)
        
//        currentView.propertyTypeLabel.isUserInteractionEnabled = true
//        let menuInteraction = UIContextMenuInteraction(delegate: self)
//        currentView.propertyTypeLabel.addInteraction(menuInteraction)

        firestore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            usersData = userData
        }
        setLanguageAndLocationLabel()
        setLanguage()
        countryPicker.languageModel = languageManager.getData()
    }
    
//    @objc func didTap(_ recognizer: UITapGestureRecognizer) {
//        let location = recognizer.location(in: currentView.propertyTypeLabel)
//        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: location)
//        if let interaction = editMenuInteraction {
//            // Present the edit menu interaction.
//            interaction.presentEditMenu(with: configuration)
//        }
//    }
    
    override func loadView() {
        view = currentView
    }
    
    func setLanguageAndLocationLabel() {
        guard let usersData else { return }
        for (language) in usersData.languages {
            languageArray.append(language.replacingOccurrences(of: " ", with: ""))
        }
        location = "\(usersData.locationDetail.country), \(usersData.locationDetail.state)"
        currentView.nationalityLabel.subTitle.text = ""

        for (index, language) in languageArray.enumerated() {
            currentView.nationalityLabel.subTitle.text! += "\(language)"
            if index != languageArray.count {
                currentView.nationalityLabel.subTitle.text! += ", "
            }
        }
        currentView.locationLabel.subTitle.text = location
    }
    
    func observeViewEvents() {
        currentView.nationalityLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            openCountryPicker()
        }
        currentView.propertyTypeLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            
            //uimenu
        }
        
        currentView.locationLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            //got location form
            gotoLocationFilterVC()
        }
        
        countryPicker.closePicker = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        countryPicker.onPicked = { [weak self] model in
            guard let self = self else { return }
            
            currentView.nationalityLabel.sideTitle.text = model.name
        }
    }
    
    func gotoLocationFilterVC() {
        let locationFilter = LocationFilterVC()
        locationFilter.userData = usersData
        navigationController?.pushViewController(locationFilter, animated: true)
    }
    
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
        countryPicker.pickerView.searchBar.textFieldAttribute(placeholderText: "Search for Language", placeholderHeight: 14)
        present(countryPicker, animated: true)
        
//        currentView.languagePickerTextField.textField.placeholder = ""
        countryPicker.sendSavedData = { [weak self] selectedLanguages in
            self?.selectedLanguage = ""
            guard let self = self else { return }
            for (index, languages) in selectedLanguages.enumerated() {
                self.selectedLanguage! +=  index == 0 ? "\(languages)" : ", \(languages)"
            }
            
            if selectedLanguages.isEmpty == true {
                self.currentView.nationalityLabel.sideTitle.text = "Tap here"
                self.currentView.nationalityLabel.subTitle.text =  ""
            } else {
                self.currentView.nationalityLabel.sideTitle.text = ""
                self.currentView.nationalityLabel.subTitle.text =  self.selectedLanguage
            }

            }
        }
    
//    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
//        // Create a custom menu with three items
//        let customMenu = UIMenu(title: "mycustom", children: [
//            UIAction(title: "menuItem1") { _ in
//                print("menuItem1")
//            },
//            UIAction(title: "menuItem2") { _ in
//                print("menuItem2")
//            },
//            UIAction(title: "menuItem3") { _ in
//                print("menuItem3")
//            }
//        ])
//        // Return the custom menu
//        return customMenu
//    }
    
    func setLanguage() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
            languageManager.setData(language: language, isSelected: languageArray.contains(language))
        }
    }
}


