//
//  DIPickerModel.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

struct NewCountryModel {
    let name, dialCode, code: String
    var state: [String]?
    let flagImage: UIImage?
}

struct CountryManager {
    private var data = [NewCountryModel]()
    
    func getData () -> [NewCountryModel] {
        return data
    }
    
    mutating func setData (name: String, dialCode: String, state: [String] = [],code: String, imageName: String) {
        data.append(NewCountryModel(name: name, dialCode: dialCode, code: code, state: state , flagImage: UIImage(named: "\(code)".lowercased())))
    }
    
    mutating func setsData (name: String, dialCode: String = "", code: String, state: [String] = [], imageName: String = "") {
        data.append(NewCountryModel(name: name, dialCode: dialCode, code: code, state: state, flagImage: UIImage(named: "\(code)".lowercased())))
    }
}
