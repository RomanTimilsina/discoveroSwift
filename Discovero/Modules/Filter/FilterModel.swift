//
//  FilterModel.swift
//  Discovero
//
//  Created by hazesoft on 19/10/2023.
//

import Foundation
struct FilterModel {
    var countryName, stateName, suburbName, propertyType ,paymentType, jobType: String?
    var noOfBedrooms, noOfBathrooms, noOfParkings, noOfPositions: Int?
    var minCost, maxCost: Double?
    var languageArray: [String]?
    
    public init(countryName: String? = nil,
                stateName: String? = nil,
                suburbName: String? = nil,
                propertyType: String? = nil,
                paymentType: String? = nil,
                jobType: String? = nil,
                noOfBedrooms: Int? = nil,
                noOfBathrooms: Int? = nil,
                noOfParkings: Int? = nil,
                noOfPositions: Int? = nil,
                minCost: Double? = nil,
                maxCost: Double? = nil,
                languageArray: [String]? = nil) {
        self.countryName = countryName
        self.stateName = stateName
        self.suburbName = suburbName
        self.propertyType = propertyType
        self.paymentType = paymentType
        self.jobType = jobType
        self.noOfBedrooms = noOfBedrooms
        self.noOfBathrooms = noOfBathrooms
        self.noOfParkings = noOfParkings
        self.noOfPositions = noOfPositions
        self.minCost = minCost
        self.maxCost = maxCost
        self.languageArray = languageArray
    }
    
    var filterCount: Int? {
        var count = 0
        
        if minCost != nil || maxCost != nil {
            count += 1
        }
        
        if countryName != nil || stateName != nil  {
            count += 1
        }
        
        if noOfBedrooms != nil  {
            count += 1
        }
        
        if noOfBathrooms != nil  {
            count += 1
        }
        
        if noOfParkings != nil  {
            count += 1
        }
        
        if noOfPositions != nil  {
            count += 1
        }
        
        if propertyType != nil  {
            count += 1
        }
        
        if paymentType != nil  {
            count += 1
        }
        
        if jobType != nil  {
            count += 1
        }
        
        if languageArray != nil  {
            count += 1
        }
        
        return count
    }
}

struct LocationFilterModel {
    var countryName, stateName: String?
    
    public init(countryName: String? = nil, stateName: String? = nil) {
        self.countryName = countryName
        self.stateName = stateName
    }
}
