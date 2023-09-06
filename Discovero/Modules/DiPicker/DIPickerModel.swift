//
//  DIPickerModel.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

struct DIPickerModel {
    let countryImage: UIImage?
    let countryName: String?
    var isSelected: Bool? = false
}

struct DIPickerManager {
    var data = [DIPickerModel]()
    
    init(){
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Brazil"))
    }
    
    func getData() -> [DIPickerModel] {
        return data
    }
}
