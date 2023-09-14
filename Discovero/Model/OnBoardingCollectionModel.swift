//
//  OnBoardingCollectionModel.swift
//  Discovero
//
//  Created by Mac on 03/09/2023.
//

import Foundation
import UIKit

struct onBoardingCollectionModel {
    let image: UIImage?
    let icons: UIImage?
    let title: String
    let description: String
}

struct OnBoardingCollectionManager {
    private var data = [onBoardingCollectionModel]()
    
    init() {
        data.append(onBoardingCollectionModel(image: UIImage(named: "onBoardingPageImage1"), icons: UIImage(named: "bedIcon"), title: "Find your  room", description:"A incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation."))
        data.append(onBoardingCollectionModel(image: UIImage(named: "onBoardingPageImage2"), icons: UIImage(named: "icon2"), title: "Explore Jobs", description: """
                                              A incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation.
                                              """))
        data.append(onBoardingCollectionModel(image: UIImage(named: "onBoardingPageImage3"), icons: UIImage(named: "icon3"), title: "Buy and sell", description: """
                                              
                                              A incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation.
                                              """ ))
        data.append(onBoardingCollectionModel(image: UIImage(named: "onBoardingPageImage4"), icons: UIImage(named: "icon4") , title: "Announcement", description: """
                                              A incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation.
                                              """))
    }
    
    func getData()  -> [onBoardingCollectionModel] {
        return data
    }
}






