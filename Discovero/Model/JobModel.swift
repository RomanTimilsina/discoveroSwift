//
//  JobModel.swift
//  Discovero
//
//  Created by admin on 01/11/2023.
//

import UIKit
struct JobModel {
    let adsTitle, description, salarySideTitle: String
    let salary: Double
    let country, state, suburb, streetName, streetNo, buildingNo: String
    let noOfPostion: Int
    let jobType: String
    
    public init(adsTitle: String, description: String, salary: Double, salarySideTitle: String, country: String, state: String, suburb: String, streetName: String = "", streetNo: String = "", buildingNo: String = "", noOfPostion: Int, jobType: String) {
        self.adsTitle = adsTitle
        self.description = description
        self.salary = salary
        self.salarySideTitle = salarySideTitle
        self.country = country
        self.state = state
        self.suburb = suburb
        self.streetName = streetName
        self.streetNo = streetNo
        self.buildingNo = buildingNo
        self.noOfPostion = noOfPostion
        self.jobType = jobType
    }
}

struct BuySellModel {
    let adsTitle, description: String
    let price: Double
    let country, state, suburb, streetName, streetNo, buildingNo: String
    let noOfItems: Int
    let productTypeLabel: String
    public init(adsTitle: String, description: String, price: Double, country: String, state: String, suburb: String, streetName: String = "", streetNo: String = "", buildingNo: String = "", noOfItems: Int, productTypeLabel: String) {
        self.adsTitle = adsTitle
        self.description = description
        self.price = price
        self.country = country
        self.state = state
        self.suburb = suburb
        self.streetName = streetName
        self.streetNo = streetNo
        self.buildingNo = buildingNo
        self.noOfItems = noOfItems
        self.productTypeLabel = productTypeLabel
    }
}
