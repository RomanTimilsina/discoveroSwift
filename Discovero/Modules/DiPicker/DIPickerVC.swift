////
////  DIPickerVC.swift
////  Discovero
////
////  Created by Mac on 06/09/2023.
////
//
import UIKit

class DIPickerVC: UIViewController {
    
    let currentView = DIPickerView()
    
    var onClosePicker: (() -> Void)?
    var onCountryPicked: ((NewCountryModel) -> Void)?
    var onLanguagePicked: (([LanguageModel]) -> Void)?
    var sendSavedData: (([String]) -> Void)?
    
    var countryModel = [NewCountryModel]()
    var searchCountryModel = [NewCountryModel]()
    var languageModel = [LanguageModel]()
    var searchLanguageModel = [LanguageModel]()
//    var savedata = [String]()
    var savedLanguageData = [String]()
    var resetOnReopen: Bool = false
    
    // MARK: used for registrationflow
    var isRegistration: Bool = false
    lazy var languageArray: [String] = []
    lazy var countLanguageSelected = languageArray.count
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if resetOnReopen {
            currentView.searchBar.searchField.text = ""
            currentView.onSearchEdit?("")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeViewEvents()
//        fetchDataFromDefault()
        savedLanguageData = languageArray
        searchLanguageModel = languageModel
        searchCountryModel = countryModel
    }

    override func loadView() {
        view = currentView
    }
    
    func observeViewEvents() {
        currentView.onCloseClick = { [weak self] in
            guard let self = self else { return }
            onClosePicker?()
            onLanguagePicked?(languageModel)
            sendSavedData?(savedLanguageData)
        }
        
        //MARK: - need to work on language search
        currentView.onSearchEdit = { [weak self] searchText in
            guard let self else { return }
            if isRegistration  {
                if searchText.isEmpty {
                    searchLanguageModel = languageModel
                } else {
                    searchLanguageModel = languageModel.filter({ $0.language.lowercased().contains(searchText.lowercased())})
                }
            } else {
                if searchText.isEmpty {
                    searchCountryModel = countryModel
                } else {
                    searchCountryModel = countryModel.filter({ item in
                        return item.name.lowercased().contains(searchText.lowercased())})
                }
            }
            currentView.table.reloadData()
        }
    }
    
    func setupTable() {
        currentView.table.register(DIPickerCell.self, forCellReuseIdentifier: DIPickerCell.identifier)
        currentView.table.dataSource = self
        currentView.table.delegate = self
    }
}

//MARK: Table Delegate
extension DIPickerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isRegistration  {
            return searchLanguageModel.count
        } else {
            return searchCountryModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
        if !isRegistration {
            let data = searchCountryModel[indexPath.row]
            cell.configureData(data: data)
            cell.selectionStyle = .none
            return cell
        } else {
            let data = searchLanguageModel[indexPath.row]
            cell.isSelected = data.isSelected!
            cell.passCheck = { [weak self] isChecked in
                guard let self = self else { return }
                if isChecked {
                    if countLanguageSelected < 3 {
                        countLanguageSelected += 1
                        cell.countryImage.image = UIImage(systemName: "checkmark.square")
                        searchLanguageModel[indexPath.row].isSelected = true
                        savedLanguageData.append(searchLanguageModel[indexPath.row].language)
                    } else {
                        cell.isChecked = !cell.isChecked
                        present(currentView.alert, animated: true, completion: nil)
                        
                        cell.countryImage.image = UIImage(systemName: "square")
                        searchLanguageModel[indexPath.row].isSelected = false
                        
                        savedLanguageData.removeAll {
                            $0 == self.searchLanguageModel[indexPath.row].language
                        }
                    }
                } else {
                    countLanguageSelected -= 1
                    searchLanguageModel[indexPath.row].isSelected = false
                    
                    savedLanguageData.removeAll {
                        $0 == self.searchLanguageModel[indexPath.row].language
                    }
                    cell.countryImage.image = UIImage(systemName: "square")
                }
                
                var data = savedLanguageData
                var select = ""
                
                for ( index , language) in data.enumerated(){
                    data.removeAll()
                    select += index == 0 ? "\(language)" : ", \(language)"
                }
                
                currentView.languageView.subTitle.text = select
                
                for (index, language) in languageModel.enumerated() {
                    if let matchingLanguage = searchLanguageModel.first(where: { $0.language == language.language }) {
                        languageModel[index] = matchingLanguage
                    }
                }
                
                CurrentUser.user.languageModel = languageModel

                onLanguagePicked?(languageModel)
                sendSavedData?(savedLanguageData)
            }
            cell.configureLanguageData(data: data)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isRegistration {
            let data = searchCountryModel[indexPath.row]
            onCountryPicked?(data)
            dismiss(animated: true)
        } else {
            //            let data = searchLanguageModel[indexPath.row]
        }
    }
}

//MARK: Fetch Data Functions
private extension DIPickerVC {
//    func fetchDataFromDefault() {
//        FireStoreDatabaseHelper()
//            .getUserDataFromDefaults { [weak self] userData in
//                guard let self, let userData else { return }
//                for (language) in userData.languages {
//                    languageArray.append(language.replacingOccurrences(of: " ", with: ""))
//                }
//            }
//    }
}

//import UIKit
//
//class DIPickerVC: UIViewController {
//    
//    let currentView = DIPickerView()
//    var countryModel = [NewCountryModel]()
//    var onClosePicker: (() -> Void)?
//    var onPicked: ((NewCountryModel) -> Void)?
//    var sendLanguageData: (([LanguageModel]) -> Void)?
//    
//    var searchModel = [NewCountryModel]()
//    var languageModel = [LanguageModel]()
//    var searchLanguageModel = [LanguageModel]()
//    var savedData = [String]()
//    var isRegistration: Bool = false
//    lazy var languageArray: [String] = []
//    lazy var countSelected = languageArray.count
//    var searchLabel: String?
//    var sendSavedData: (([String]) -> Void)?
//    var firestore = FireStoreDatabaseHelper()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTable()
//        observeEvents()
//        searchModel = countryModel
//        
//        firestore.getUserDataFromDefaults { [weak self] userData in
//            guard let self, let userData else { return }
//            for (language) in userData.languages {
//                languageArray.append(language.replacingOccurrences(of: " ", with: ""))
//            }
//        }
//        savedData = languageArray
//        searchLanguageModel = languageModel
//    }
//    
//    override func loadView() {
//        super.loadView()
//        view = currentView
//    }
//    
//    func observeEvents() {
//        currentView.onCloseClick = { [weak self] in
//            guard let self = self else { return }
//            onClosePicker?()
//        }
//        
//        //MARK: - need to work on languag filter
//        currentView.onSearchEdit = { [weak self] searchText in
//            guard let self else { return }
//            if isRegistration  {
//                if searchText.isEmpty {
//                    searchLanguageModel = languageModel
//                } else {
//                    searchLanguageModel = languageModel.filter({ $0.language.lowercased().contains(searchText.lowercased())
//                    })
//                }
//            } else {
//                if searchText.isEmpty {
//                    searchModel = countryModel
//                } else {
//                    searchModel = countryModel.filter({ item in
//                        return item.name.lowercased().contains(searchText.lowercased())
//                    })
//                }
//            }
//            currentView.table.reloadData()
//        }
//    }
//    
//    func setupTable() {
//        currentView.table.register(DIPickerCell.self, forCellReuseIdentifier: DIPickerCell.identifier)
//        currentView.table.dataSource = self
//        currentView.table.delegate = self
//    }
//}
//
//extension DIPickerVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isRegistration  {
//            return searchLanguageModel.count
//        } else {
//            return searchModel.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
//        if !isRegistration {
//            let data = searchModel[indexPath.row]
//            cell.configureData(data: data)
//            cell.selectionStyle = .none
//            return cell
//        } else {
//            
//            let data = searchLanguageModel[indexPath.row]
//            
//            cell.isSelected = data.isSelected!
//            cell.passCheck = { [weak self] isChecked in
//                guard let self = self else { return }
//                if isChecked {
//                    if countSelected < 3 {
//                        countSelected += 1
//                        cell.countryImage.image = UIImage(systemName: "checkmark.square")
//                        searchLanguageModel[indexPath.row].isSelected = !searchLanguageModel[indexPath.row].isSelected!
//                        savedData.append(searchLanguageModel[indexPath.row].language)
//                    } else {
//                        cell.isChecked = !cell.isChecked
//                        present(currentView.alert, animated: true, completion: nil)
//                        
//                        cell.countryImage.image = UIImage(systemName: "square")
//                        searchLanguageModel[indexPath.row].isSelected = !searchLanguageModel[indexPath.row].isSelected!
//                        savedData.removeAll {
//                            $0 == self.searchLanguageModel[indexPath.row].language
//                        }
//                    }
//                } else {
//                    countSelected -= 1
//                    searchLanguageModel[indexPath.row].isSelected = !searchLanguageModel[indexPath.row].isSelected!
//                    savedData.removeAll {
//                        $0 == self.searchLanguageModel[indexPath.row].language
//                    }
//                    cell.countryImage.image = UIImage(systemName: "square")
//                }
//                
//                for (index, language) in languageModel.enumerated() {
//                    if let matchingLanguage = searchLanguageModel.first(where: { $0.language == language.language }) {
//                        languageModel[index] = matchingLanguage
//                    }
//                }
//                sendLanguageData?(languageModel)
//                sendSavedData?(savedData)
//            }
//            
//            cell.configureLanguageData(data: data)
//            cell.selectionStyle = .none
//            return cell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if !isRegistration {
//            let data = searchModel[indexPath.row]
//            onPicked?(data)
//            dismiss(animated: true)
//        } else {
////            let data = searchLanguageModel[indexPath.row]
//        }
//    }
//}


