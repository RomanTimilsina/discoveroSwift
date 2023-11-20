//
//  PostModel.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

struct PostModel {
  let name: String
  let country, state, suburb, streetName, streetNo, buildingNo: String
  let caption, description, propertyType: String
  let price: Double
  let noOfBedroom, noOfBathroom, noOfParkings: Int
  let isAnonymous: Bool
    
    public init(name: String = "", country: String = "", state: String = "", suburb: String = "", streetName: String = "", streetNo: String = "", buildingNo: String = "", caption: String = "", description: String = "", propertyType: String = "", price: Double = 0.0, noOfBedroom: Int = 1, noOfBathroom: Int = 1, noOfParkings: Int = 0, isAnonymous: Bool = false) {
        self.name = name
        self.country = country
        self.state = state
        self.suburb = suburb
        self.streetName = streetName
        self.streetNo = streetNo
        self.buildingNo = buildingNo
        self.caption = caption
        self.description = description
        self.propertyType = propertyType
        self.price = price
        self.noOfBedroom = noOfBedroom
        self.noOfBathroom = noOfBathroom
        self.noOfParkings = noOfParkings
        self.isAnonymous = isAnonymous
    }
}

