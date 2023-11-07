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
    let country, state, suburb: String
    let noOfPostion: Int
    let jobType: String
    
    public init(adsTitle: String, description: String, salary: Double, salarySideTitle: String, country: String, state: String, suburb: String, noOfPostion: Int, jobType: String) {
        self.adsTitle = adsTitle
        self.description = description
        self.salary = salary
        self.salarySideTitle = salarySideTitle
        self.country = country
        self.state = state
        self.suburb = suburb
        self.noOfPostion = noOfPostion
        self.jobType = jobType
    }
}

struct BuySellModel {
    let adsTitle, description: String
    let price: Double
    let country, state, suburb: String
    let noOfItems: Int
    let productTypeLabel: String
    public init(adsTitle: String, description: String, price: Double, country: String, state: String, suburb: String, noOfItems: Int, productTypeLabel: String) {
        self.adsTitle = adsTitle
        self.description = description
        self.price = price
        self.country = country
        self.state = state
        self.suburb = suburb
        self.noOfItems = noOfItems
        self.productTypeLabel = productTypeLabel
    }
}
