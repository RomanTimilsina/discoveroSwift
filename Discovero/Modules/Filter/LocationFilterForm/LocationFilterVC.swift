//
//  LocationFilterVC.swift
//  Discovero
//
//  Created by Mac on 12/10/2023.
//

import UIKit
class LocationFilterVC: UIViewController {
    
    var onSaveClick: ((String, String, String) -> Void)?
    
    lazy var countryPicker = DIPickerVC()
    var currentView = LocationFilterView()
    var userData: UserData?
    var firestore = FireStoreDatabaseHelper()
    var countryManager = CountryManager()
    var newCountryModel = CountryManager()
    
    var stateMenuTable: [String] = []
    var countryList: [CountryStateModel] = []
    var selectedCountyList: [String] = []
    var selectedCountryName = ""
    var runForTheFirstTime = true
    var runOnce = true
    let countries: [CountryModel] = Bundle.main.decode(from: "Countries.json")
    weak var filterSelectorVC: FilterSelectorVC?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let text = currentView.countryView.subTitle.text, let text2 = currentView.stateView.subTitle.text {
            if text != "" && text2 != "" {
                currentView.saveButton.setValidState()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentView.tableView.reloadData()
        currentView.tableView.canCancelContentTouches = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.stateView.coverButton.isEnabled = false
        setupTable()
        countriesAndState()
        currentView.suburbView.textField.delegate = self
        currentView.streetNameView.textField.delegate = self
        currentView.streetNumView.textField.delegate = self
        currentView.buldingNumView.textField.delegate = self
        currentView.countryView.subTitle.text = userData?.country
        currentView.stateView.subTitle.text = userData?.locationDetail.state
        countryPicker.countryModel = countryManager.getData()
        
        currentView.saveButton.setInvalidState()
        observeViewEvents()
    }
    func countriesAndState() {
        firestore.getCountryWithState() { [weak self] countriesAndStates in
            guard let self else { return }
            for countryAndStates in countriesAndStates {
                for (index,_) in countries.enumerated() {
                    if countries[index].name == countryAndStates.name {
                        if runForTheFirstTime {
                            countryList.append(countryAndStates)
                            debugPrint(countriesAndStates)
                        }
                        let name = countries[index].code.lowercased()
                        if UIImage(named: name) != nil {
                            if selectedCountryName == "" {
                                selectedCountryName = userData?.country ?? ""
                            }
                            setState(countryName: selectedCountryName)
                            newCountryModel.setData(name: countries[index].name, dialCode: countries[index].dialCode, code: countries[index].code, imageName: countries[index].code)
                        }
                    }
                }
            }
        }
    }
    
    func setState(countryName: String) {
        for country in countryList {
            if countryName == country.name {
                for state in country.state {
                    stateMenuTable.append(state.name)
                }
                currentView.tableView.reloadData()
            }
        }
        countryList.removeAll()
    }
    
    override func loadView() {
        view = currentView
        navigationController?.navigationBar.isHidden = true
    }
    
    func observeViewEvents() {
        currentView.onTableViewClick = { [weak self] hideTable in
            guard let self else { return }
            hideTable ? hidesTable() : showTable()
        }
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
        countryPicker.onCountryPicked = { [weak self] model in
            guard let self = self else { return }
            debugPrint(model.name)
            countriesAndState()
            currentView.countryView.subTitle.text = model.name
            currentView.stateView.subTitle.text = ""
            currentView.stateView.coverButton.isEnabled = false
            stateMenuTable = []
            selectedCountryName = model.name
            setState(countryName: model.name)
        }
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        currentView.handleSave = { [weak self] country, state, suburb in
            guard let self else { return }
            onSaveClick?(country, state, suburb)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setupTable() {
        currentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        currentView.tableView.dataSource = self
        currentView.tableView.delegate = self
        currentView.tableView.rowHeight = UITableView.automaticDimension
        currentView.tableView.estimatedRowHeight = 40
    }
    
    func showTable() {
        currentView.tableView.isHidden = false
        currentView.overlayView.isUserInteractionEnabled = true
    }
    
    func hidesTable() {
        currentView.tableView.isHidden = true
        //    currentView.overlayView.isUserInteractionEnabled = false
    }
    
    //  func resetStateMenu() {
    //    runOnce = true
    //    currentView.stateView.button.isEnabled = true
    //    currentView.stateView.button.isHidden = false
    //    currentView.stateView.button.showsMenuAsPrimaryAction = true
    //    currentView.stateView.button.menu = addStateMenuFirst(currentView.stateView.subTitle.text ?? "")
    //  }
    
}

// MARK: Textfield delegates
extension LocationFilterVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        currentView.suburbView.lineView.backgroundColor = Color.gray800
        currentView.streetNameView.lineView.backgroundColor = Color.gray800
        currentView.streetNumView.lineView.backgroundColor = Color.gray800
        currentView.buldingNumView.lineView.backgroundColor = Color.gray800
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == currentView.suburbView.textField {
            setLineForTextField(view: currentView.suburbView)
        }
        if textField == currentView.streetNameView.textField {
            setLineForTextField(view: currentView.streetNameView)
        }
        if textField == currentView.streetNumView.textField {
            setLineForTextField(view: currentView.streetNumView)
        }
        if textField == currentView.buldingNumView.textField {
            setLineForTextField(view: currentView.buldingNumView)
        }
        func setLineForTextField(view: UIView) {
            if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                guard let line = view.subviews.last else { return }
                if !updatedText.isEmpty {
                    line.backgroundColor = Color.primary
                } else {
                    line.backgroundColor = Color.gray800
                }
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case currentView.suburbView.textField:
            currentView.streetNameView.textField.becomeFirstResponder() // Move to the next text field
        case currentView.streetNameView.textField:
            currentView.streetNumView.textField.becomeFirstResponder() // Move to the next text field
        case currentView.streetNumView.textField:
            currentView.buldingNumView.textField.becomeFirstResponder() // Move to the next text field
        case currentView.buldingNumView.textField:
            currentView.buldingNumView.textField.resignFirstResponder() // Dismiss the keyboard for the last text field
        default:
            break
        }
        return true
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
        countryPicker.currentView.searchBar.textFieldAttribute(placeholderText: "Search for Nation", placeholderHeight: 14)
        countryPicker.currentView.languageView.isHidden = true
        countryPicker.currentView.languageView.constraintHeight(constant: 0)
        present(countryPicker, animated: true)
    }
}

extension LocationFilterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //    setState(countryName: userData?.country ?? "")
        return stateMenuTable.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = stateMenuTable[indexPath.row]
        cell.backgroundColor = Color.gray500
        cell.textLabel?.textColor = Color.appBlack
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentView.stateView.subTitle.text = stateMenuTable[indexPath.row]
        currentView.hideTable = true
        currentView.overlayView.isHidden = true
        hidesTable()
    }
}





