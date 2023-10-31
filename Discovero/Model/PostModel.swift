//
//  PostModel.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

struct PostModel {
  let name: String
  let country, state, suburb : String
  let caption, description, propertyType: String
  let price: Double
  let noOfBedroom, noOfBathroom, noOfParkings: Int
  let isAnonymous: Bool
    
    public init(name: String, country: String, state: String, suburb: String, caption: String, description: String, propertyType: String, price: Double, noOfBedroom: Int, noOfBathroom: Int, noOfParkings: Int, isAnonymous: Bool) {
        self.name = name
        self.country = country
        self.state = state
        self.suburb = suburb
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

