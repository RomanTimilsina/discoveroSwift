//
//  SharedUserData.swift
//  Discovero
//
//  Created by Mac on 06/11/2023.
//

import Foundation

class CurrentUser {
    static let user = CurrentUser()
    
    var data: UserData?
    
    private init() {}
}
