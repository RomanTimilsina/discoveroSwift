//
//  DIPickerModel.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

struct NewCountryModel {
    let name, dialCode, code: String
    let flagImage: UIImage?
}

//func createNewCountryModel(from country: CountryModel) -> NewCountryModel {
//    // Assuming your flag images are stored in the "Assets" directory
//    let flagImageName = country.code  // Use the country code as the image name
//    let flagImage = UIImage(named: flagImageName)
//    
//    return NewCountryModel(name: country.name, dialCode: country.dialCode, code: country.code, flagImage: UIImage(named: country.code))
//}

struct CountryManager {
    private var data = [NewCountryModel]()
    
    init() {
        
    }
    
    func getData () -> [NewCountryModel] {
        return data
    }
    
    mutating func setData (name: String, dialCode: String, code: String, imageName: String) {
        data.append(NewCountryModel(name: name, dialCode: dialCode, code: code, flagImage: UIImage(named: "\(code)".lowercased())))
    }
}
