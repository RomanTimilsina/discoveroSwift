//
//  MyProfileVC.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = MyProfileView()
    
    let languagePicker = DIPickerVC()
    var languageManager = LanguageManager()
    let selectGender = SelectGenderVC()

    let value1 = ["name", "email"]
    let value2 = ["Your name", "Your email" ]
    
    var selectedLanguageArray: [String] = []
    var selectedLanguage: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        currentView.genderView.subTitle.text = selectGender.selectedGender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        observeViewEvents()
        setLanguage()
        languagePicker.languageModel = languageManager.getData()
    }
    
    func observeViewEvents() {
        
        for (index, profile) in currentView.profileArray.enumerated() {
            profile.profileTap = { [weak self] text in
                guard let self = self else { return }
                setProfileTab(index: index)
            }
        }
        
        currentView.addressView.profileTap = { [weak self] text in
            guard let self else { return }
            navigationController?.pushViewController(LocationFilterVC(), animated: true)
        }
        
        currentView.languagesView.profileTap = { [weak self] text in
            guard let self else { return }
            openLanguagePicker()
        }
        
        currentView.genderView.profileTap = { [weak self] text in
            guard let self else { return }
            selectGender.hidesBottomBarWhenPushed = true

            navigationController?.pushViewController(selectGender, animated: true)
        }
        
        currentView.notificationView.profileTap = { [weak self] text in
            guard let self else { return }

            currentView.notification.isHidden = false
        }
        
        currentView.notification.handleClose = { [weak self] in
            guard let self else { return }

            currentView.notification.isHidden = true
        }
    }
    
    private func setLanguage() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
            languageManager.setData(language: language, isSelected: selectedLanguageArray.contains(language))
        }
    }

    
//    func gotoLocationFilterVC() {
//        let locationFilterVC = LocationFilterVC()
//        locationFilterVC.userData = usersData
//        
//        locationFilterVC.currentView.streetNameView.removeFromSuperview()
//        locationFilterVC.currentView.streetNumView.removeFromSuperview()
//        locationFilterVC.currentView.buldingNumView.removeFromSuperview()
//    
//        navigationController?.pushViewController(locationFilterVC, animated: true)
//        
//        locationFilterVC.onSaveClick = { [weak self] country, state, suburb in
//            guard let self else { return }
//            currentView.locationLabel.subTitle.text = "\(country ?? ""), \(state ?? "")"
//            currentView.countryName = country
//            currentView.stateName = state
//        }
//    }
    
    func openLanguagePicker() {
                
        languagePicker.modalPresentationStyle = .fullScreen
        if let sheet = languagePicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        
        languagePicker.isRegistration = true
        languagePicker.currentView.searchBar.textFieldAttribute(placeholderText: "Search for Language", placeholderHeight: 14)
        present(languagePicker, animated: true)
        
        languagePicker.sendSavedData = { [weak self] selectedLanguages in
            guard let self = self else { return }
            self.selectedLanguage = ""
            self.selectedLanguageArray = selectedLanguages
            
            for (index, languages) in selectedLanguages.enumerated() {
                self.selectedLanguage! +=  index == 0 ? "\(languages)" : ", \(languages)"
            }
            
            if selectedLanguages.isEmpty == true {
                self.currentView.languagesView.subTitle.text =  ""
            } else {
                self.currentView.languagesView.sideTitle.text = ""
                self.currentView.languagesView.subTitle.text =  self.selectedLanguage
            }
            
            currentView.languageArray = selectedLanguageArray
        }
        
        languagePicker.onClosePicker = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func setProfileTab(index: Int) {
        let profileItem = ProfileItemVC()
        
        if index < 2{
            profileItem.onTitle = value1[index]
            profileItem.onPlaceholder = value2[index]
            navigationController?.pushViewController(profileItem, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Color.appBlack
        view = currentView
    }
}
