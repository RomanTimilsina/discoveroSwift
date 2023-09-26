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

struct CountryModel: Codable {
    let name, dialCode, code: String

    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
    }
}


struct DIPickerManager {
    var data = [DIPickerModel]()
    
    init(){
        data.append(DIPickerModel(countryImage: UIImage(named: "icn_brazil"), countryName: "Nepalese"))
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
