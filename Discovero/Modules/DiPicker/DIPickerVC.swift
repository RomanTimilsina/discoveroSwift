//
//  DIPickerVC.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class DIPickerVC: UIViewController {
    
    let pickerView = DIPickerView()
    var countryModel = [NewCountryModel]()
    var closePicker: (() -> Void)?
    var onPicked: ((NewCountryModel) -> Void)?
    let registration = RegistrationVC()
    var searchModel = [NewCountryModel]()
//    var state: String?
    var languageModel = [LanguageModel]()
    var searchLanguageModel = [LanguageModel]()
    var savedData = [LanguageModel]()
    var isRegistration: Bool = false
//    var checker: Bool?
//    let languageManager = LanguageManager()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        searchModel = countryModel
        searchLanguageModel = languageModel
    }
    
    override func loadView() {
        super.loadView()
        view = pickerView
    }
    
    func observeEvents() {
        pickerView.onCloseClick = {[weak self] in
            guard let self = self else {return}
            closePicker?()
        }
                //MARK: - need to work on languag filter
        pickerView.onSarchEdit = {[weak self] searchText in
            guard let self else {return}
            if isRegistration  {
                if searchText.isEmpty {
                    searchLanguageModel = languageModel
                } else {
                    searchLanguageModel = languageModel.filter({ $0.language.lowercased().contains(searchText.lowercased())
                    })
                }
            } else {
                if searchText.isEmpty {
                    searchModel = countryModel
                } else {
                    searchModel = countryModel.filter({ item in
                        return item.name.lowercased().contains(searchText.lowercased())
                    })
                }
            }
            pickerView.table.reloadData()
        }
    }
    
    func setupTable() {
        pickerView.table.register(DIPickerCell.self, forCellReuseIdentifier: DIPickerCell.identifier)
        pickerView.table.dataSource = self
        pickerView.table.delegate = self
    }
}

extension DIPickerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isRegistration  {
            return searchLanguageModel.count
        } else {
            return searchModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
        if !isRegistration {
            let data = searchModel[indexPath.row]
            cell.configureData(data: data)
            cell.selectionStyle = .none
            return cell
        } else {
            let data = searchLanguageModel[indexPath.row]
            cell.passCheck = {[weak self] isChecked in
                guard let self else {return}
                if isChecked {
                    count += 1
                }
                
                if !isChecked {
                    count -= 1
                }
                
                if count < 4 {
                    searchLanguageModel[indexPath.row].isSelected = isChecked
                    
                    savedData.append(searchLanguageModel[indexPath.row])
                    print(savedData)
                    cell.countryImage.image = isChecked ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
                }
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
            let data = searchModel[indexPath.row]
            onPicked?(data)
            registration.isSelected = true
            dismiss(animated: true)
        } else {
            let data = searchLanguageModel[indexPath.row]
            
//            dismiss(animated: true)
        }
    }
}
