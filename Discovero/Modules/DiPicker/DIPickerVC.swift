//
//  DIPickerVC.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class DIPickerVC: UIViewController {
    
    let pickerView = DIPickerView()
    var getModel = DIPickerManager()
    var closePicker: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
    }
    
    override func loadView() {
        super.loadView()
        view = pickerView
    }
    
    func observeEvents() {
        pickerView.onClose = {[weak self] in
            guard let self = self else {return}
            closePicker?()
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
        getModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DIPickerCell.identifier, for: indexPath) as! DIPickerCell
        let data = getModel.getData()[indexPath.row]
        cell.configureData(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
