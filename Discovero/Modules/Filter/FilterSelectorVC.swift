//
//  FilterVC.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit
import MultiSlider

class FilterSelectorVC: UIViewController, UISheetPresentationControllerDelegate {
    
    var handlePop: ((String, String, String, String, [String], String, String, String, String, String) -> Void)?
    
    let currentView = FilterSelectorView()
    lazy var countryPicker = DIPickerVC()
    var languageManager = LanguageManager()
    var selectedLanguage: String?
    var selectedLanguages: [String] = []
    var firestore = FireStoreDatabaseHelper()
    var languageArray: [String] = []
    var usersData: UserData?
    var location = ""
    let locationFilter = LocationFilterVC()
    var country, state, suburb, noOfBedroom, noOfBathroom, noOfParking, property: String?
    var countryName, stateName, suburbName, propertyType, noOfBedrooms, noOfBathrooms, noOfParkings, minCost, maxCost: String?
    var selectLanguages: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
        navigationController?.navigationBar.isHidden = true
        
        firestore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            usersData = userData
            locationFilter.userData = userData
        }
        
        setInitialData()
        setLanguageAndLocationLabel()
        setLanguage()
        countryPicker.languageModel = languageManager.getData()
    }
    
    override func loadView() {
        view = currentView
    }
    
    func setInitialData() {
        guard let usersData else { return }

        countryName = usersData.country
        stateName = usersData.locationDetail.state
        suburbName = usersData.locationDetail.suburb

        selectLanguages = usersData.languages
        debugPrint(selectLanguages)

    }
    
    func resetData() {
        setInitialData()
        
        // bathroom, beddroom and parkings selector reset
        for selector in currentView.selectors {
            for view in selector.viewsArray {
               if let label = view.subviews.first as? UILabel {
                    if view == selector.viewsArray[0] {
                        label.textColor = Color.appWhite
                        view.backgroundColor = Color.gray400
                                        
                    } else {
                        label.textColor = Color.gray400
                        view.backgroundColor = Color.gray800
                    }
                }
            }
            noOfBedroom = "Any"
            noOfBathroom = "Any"
            noOfParkings = "Any"
        }
        // range reset
        currentView.rangeSlider.value = [ 0, 5000]
        self.minCost = "0.0"
        self.maxCost = "5000.0"
        currentView.priceRange.text = "$0 to $5000"
        // property reset
        currentView.propertyTypeLabel.subTitle.text = "Any"
        countryPicker.languageModel = languageManager.getData()
        // country, state and suburb reset
        currentView.locationLabel.subTitle.text = "\(usersData?.country ?? ""), \(usersData?.locationDetail.state ?? "")"
        locationFilter.currentView.countriesTextField.text = usersData?.locationDetail.country ?? ""
        locationFilter.currentView.statesTextField.text = usersData?.locationDetail.state ?? ""
        locationFilter.currentView.suburbTextField.text = usersData?.locationDetail.suburb ?? ""
//        locationFilter.resetStateMenu()
    }
    
    func setLanguageAndLocationLabel() {
        guard let usersData else { return }

        // remove space from languages
        currentView.nationalityLabel.subTitle.text = ""

        for (language) in usersData.languages {
            languageArray.append(language.replacingOccurrences(of: " ", with: ""))
        }
        // add , between languages
        for (index, language) in languageArray.enumerated() {
            currentView.nationalityLabel.subTitle.text! += " \(language)"
            if index != languageArray.count - 1 {
                currentView.nationalityLabel.subTitle.text! += ", "
            }
            //initial values
        }
        // set country and state
        location = "\(usersData.locationDetail.country), \(usersData.locationDetail.state)"
        currentView.locationLabel.subTitle.text = location
    }
    
    func observeViewEvents() {
        currentView.nationalityLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            openCountryPicker()
        }
        
        currentView.locationLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
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
        
        locationFilter.handlePop = { [weak self] country, state, suburb in
            guard let self else { return }
            self.country = country
            self.state = state
            self.suburb = suburb
            currentView.locationLabel.subTitle.text = "\(country), \(state)"
        }
        
        currentView.handleReset = { [weak self] in
            guard let self else { return }

            resetData()
        }
        
        currentView.handleSearch = { [weak self] property, minCost, maxCost in
            guard let self else { return }

            if let country {
                countryName = country
            }
            
            if let state {
                stateName = state
            }
            
            if let suburb {
                suburbName = suburb
            }
            
            if let noOfBedroom {
                self.noOfBedrooms = noOfBedroom
            }
            
            if let noOfBathroom {
                self.noOfBathrooms = noOfBathroom
            }
            
            if let noOfParking {
                self.noOfParkings = noOfParking
            }
            
            print(selectLanguages)

            self.propertyType = property
            if !selectedLanguages.isEmpty {
                self.selectLanguages = countryPicker.savedData
            }
            
            print(selectLanguages)
            self.minCost = minCost
            self.maxCost = maxCost

            handlePop?(countryName ?? "", stateName ?? "", suburbName ?? "", propertyType ?? "Any", selectLanguages, noOfBedrooms ?? "Any", noOfBathrooms ?? "Any", noOfParkings ?? "Any", self.minCost ?? "0", self.maxCost ?? "5000")
            navigationController?.popViewController(animated: true)

        }
        
        currentView.bedroomSelector.handleTap = { [weak self] noOfBedroom in
            guard let self = self else { return }
            self.noOfBedroom = noOfBedroom
        }
        
        currentView.bathroomSelector.handleTap = { [weak self] noOfBathroom in
            guard let self = self else { return }
            self.noOfBathroom = noOfBathroom
        }
        
        currentView.parkingSelector.handleTap = { [weak self] noOfParking in
            guard let self = self else { return }
            self.noOfParking = noOfParking
        }
    }
    
    func gotoLocationFilterVC() {
        locationFilter.userData = usersData
        navigationController?.pushViewController(locationFilter, animated: true)
    }
    
    func setLanguage() {
        let country: [String] = [
            "Afar", "Afrikaans", "Albanian", "Amharic", "Arabic", "Aramaic", "Armenian", "Assamese", "Azerbaijani", "Balochi", "Basque", "Belarusian", "Bengali", "Berber", "Bhojpuri", "Bodo", "Bosnian", "Breton", "Bulgarian", "Burmese", "Cantonese", "Catalan", "Cebuano", "Chechen", "Chewa", "Chinese", "Comorian", "Corsican", "Creole", "Croatian", "Czech", "Dakhini", "Danish", "Dogri", "Dutch", "Dzongkha", "English", "Esperanto", "Estonian", "Ewe", "Faroese", "Filipino", "Finnish", "French", "Frisian", "Fulani", "Galician", "Garhwali", "Georgian", "German", "Greek", "Guarani", "Gujarati", "Hakka", "Haryanvi", "Hausa", "Hawaiian", "Hebrew", "Hiligaynon", "Hindi", "Hmong", "Hokkien", "Hungarian", "Icelandic", "Igbo", "Indonesian", "Irish", "Italian", "Jamaican Patois", "Japanese", "Javanese", "Kannada", "Kashmiri", "Kazakh", "Khmer", "Kikongo", "Kinyarwanda", "Kirundi", "Kodava", "Konkani", "Korean", "Kumaoni", "Kurdish", "Kutchi", "Kyrgyz", "Lao", "Latin", "Latvian", "Lingala", "Lithuanian", "Luo", "Luxembourgish", "Macedonian", "Maithili", "Malagasy", "Malay", "Malayalam", "Maltese", "Mandarin", "Maori", "Marathi", "Marwari", "Mayan", "Meitei", "Mongolian", "Montenegrin", "Nahuatl", "Nepali", "Norwegian", "Occitan", "Oriya", "Oromo", "Pahari", "Papiamento", "Pashto", "Persian", "Polish", "Portuguese", "Punjabi", "Quechua", "Rajasthani", "Romanian", "Romansh", "Russian", "Sami", "Sankethi", "Sanskrit", "Santali", "Saurashtra", "Sepedi", "Serbian", "Sesotho", "Setswana", "Sign Language", "Sindhi", "Sinhala", "Slovak", "Slovenian", "Somali", "Spanish", "Swahili", "Swati", "Swedish", "Tagalog", "Taiwanese", "Tajik", "Tamil", "Telugu", "Teochew", "Thai", "Tibetan", "Tigrinya", "Tsonga", "Tulu", "Turkish", "Ukrainian", "Urdu", "Venda", "Vietnamese", "Welsh", "Yiddish", "Yoruba", "Zulu"
        ]
        
        for language in country {
            languageManager.setData(language: language, isSelected: languageArray.contains(language))
        }
    }
}

// MARK: Calling DIPicker as countryPicker to display the selectedLanguages on Nationality
private extension FilterSelectorVC{
    
    func openCountryPicker() {
        countryPicker.modalPresentationStyle = .fullScreen
        if let sheet = countryPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        
        countryPicker.isRegistration = true
        countryPicker.pickerView.searchBar.textFieldAttribute(placeholderText: "Search for Language", placeholderHeight: 14)
        present(countryPicker, animated: true)
        
        countryPicker.sendSavedData = { [weak self] selectedLanguages in
            self?.selectedLanguage = ""
            guard let self = self else { return }
            print(selectedLanguages)
                self.selectedLanguages = selectedLanguages
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
}

