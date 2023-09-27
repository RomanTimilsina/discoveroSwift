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
    var state: String?
    var languageModel = [LanguageModel]()
    var isRegistration: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        searchModel = countryModel
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
        
        pickerView.onSarchEdit = {[weak self] searchText in
            guard let self else {return}
            if searchText.isEmpty {
                searchModel = countryModel
            } else {
                searchModel = countryModel.filter({ item in
                    return item.name.lowercased().contains(searchText.lowercased())
                })
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
            return languageModel.count
        } else {
            return searchModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isRegistration {
            let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
            let data = searchModel[indexPath.row]
            cell.configureData(data: data)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
            let data = languageModel[indexPath.row]
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
            let data = languageModel[indexPath.row]
            
            dismiss(animated: true)
        }
    }
}
