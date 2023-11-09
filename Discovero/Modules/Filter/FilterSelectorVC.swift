//
//  FilterVC.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit
import MultiSlider

class FilterSelectorVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = FilterSelectorView()
    
    var onSearchClick: ((FilterModel) -> Void)?
    
    let languagePicker = DIPickerVC()
    var languageManager = LanguageManager()
    var usersData: UserData?
    var selectedLanguageArray: [String] = []
    var selectedLanguage: String?
    var filterChoice: FilterChoice?
    var filterModel = FilterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        observeViewEvents()
        setInitialData()
        configView()
        languagePicker.languageModel = languageManager.getData()
        navigationController?.navigationBar.isHidden = true
        
        guard let filterChoice else { return }
        
        switch filterChoice {
        case .room : setAsRoomFilter()
        case .job : setAsJobFilter()
        case .buySell: break
        }
    }
    
    func setAsJobFilter() {
        currentView.bedroomSelector.removeFromSuperview()
        currentView.bathroomSelector.removeFromSuperview()
        currentView.parkingSelector.removeFromSuperview()
        currentView.propertyTypeLabel.removeFromSuperview()
    }
    
    func setAsRoomFilter() {
        currentView.paymentTypeLabel.removeFromSuperview()
        currentView.jobTypeLabel.removeFromSuperview()
    }
    
    override func loadView() {
        view = currentView
    }
    
    func setInitialData() {
        guard let usersData else { return }
        filterModel = FilterModel(countryName: usersData.country, stateName: usersData.locationDetail.state)
    }
    
    func resetData() {
        //MARK: Reset View
        currentView.resetView(usersData: usersData)
        
        currentView.countryName = usersData?.country ?? ""
        currentView.stateName = usersData?.locationDetail.state ?? ""
        filterModel.propertyType = nil
        currentView.noOfBedrooms = 0
        currentView.noOfBathrooms = 0
        currentView.noOfParkings = 0
        currentView.maxCost = nil
        currentView.minCost = nil
        currentView.languageArray = usersData?.languages
    }
    
    
    func observeViewEvents() {
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.locationLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            gotoLocationFilterVC()
        }
        
        currentView.languageLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            openLanguagePicker()
        }
        
        currentView.onSearchClick = { [weak self] filterModel in
            guard let self, let filterModel else { return }
            onSearchClick?(filterModel)
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onResetClick = { [weak self] in
            guard let self else { return }
            resetData()
        }
    }
    
    func gotoLocationFilterVC() {
        let locationFilterVC = LocationFilterVC()
        locationFilterVC.userData = usersData
        
        locationFilterVC.currentView.streetNameView.removeFromSuperview()
        locationFilterVC.currentView.streetNumView.removeFromSuperview()
        locationFilterVC.currentView.buldingNumView.removeFromSuperview()
        
        navigationController?.pushViewController(locationFilterVC, animated: true)
        
        locationFilterVC.onSaveClick = { [weak self] country, state, suburb in
            guard let self else { return }
            currentView.locationLabel.subTitle.text = "\(country ?? ""), \(state ?? "")"
            currentView.countryName = country
            currentView.stateName = state
        }
    }
}

// MARK: -Calling DIPicker as LanguagePicker to display the selectedLanguages on Nationality
private extension FilterSelectorVC{
    
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
        languagePicker.currentView.languageView.isHidden = true
        languagePicker.currentView.languageView.constraintHeight(constant: 0)
        present(languagePicker, animated: true)
        
        languagePicker.sendSavedData = { [weak self] selectedLanguages in
            guard let self = self else { return }
            self.selectedLanguage = ""
            self.selectedLanguageArray = selectedLanguages
            
            for (index, languages) in selectedLanguages.enumerated() {
                self.selectedLanguage! +=  index == 0 ? "\(languages)" : ", \(languages)"
            }
            
            if selectedLanguages.isEmpty == true {
                self.currentView.languageLabel.sideTitle.text = "Tap here"
                self.currentView.languageLabel.subTitle.text =  ""
            } else {
                self.currentView.languageLabel.sideTitle.text = ""
                self.currentView.languageLabel.subTitle.text =  self.selectedLanguage
            }
            
            currentView.languageArray = selectedLanguageArray
        }
        
        languagePicker.onClosePicker = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UI Related function
extension FilterSelectorVC {
    func configView() {
        currentView.configView(model: FilterModel(countryName: usersData?.country,
                                                  stateName: usersData?.locationDetail.state))
    }
}

//MARK: - Fetch Data
private extension FilterSelectorVC {
    private func fetchUserData() {
        //        FireStoreDatabaseHelper().getUserDataFromDefaults { [weak self] userData in
        //            guard let self, let userData else { return }
        ////            usersData = userData
        //        }
        
        usersData = CurrentUser.user.data
        
        setLanguage()
    }
    
    private func setLanguage() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
            languageManager.setData(language: language, isSelected: selectedLanguageArray.contains(language))
        }
    }
}

enum FilterChoice {
    case room
    case job
    case buySell
}
