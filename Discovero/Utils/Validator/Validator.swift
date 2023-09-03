// Copyright © 2021 Minor. All rights reserved.

import Foundation

enum FieldType {
    case email
    case password
    case phone
    case houseNumber
    case name
    case normal
    case cardName
    case cardNumber
    case cardMonth
    case cardYear
    case cvv
    case postalCode
    case taxId
    case bankAccount
    
    var minLength: Int? {
        switch self {
        case .email: return 3
        case .password: return 8
        case .phone: return 8
        case .houseNumber: return 1
        case .name: return 1
        case .cardMonth: return 2
        case .cardName: return 2
        case .cardNumber: return 16
        case .cardYear: return 4
        case .cvv: return 3
        case .postalCode: return 5
        case .taxId: return 13
        case .normal: return 1
        case .bankAccount: return 4
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .email: return 50
        case .password: return 15
        case .phone: return 11
        case .houseNumber: return 12
        case .name: return 50
        case .cardMonth: return 2
        case .cardName: return 26
        case .cardNumber: return 16
        case .cardYear: return 4
        case .cvv: return 3
        case .postalCode: return 5
        case .taxId: return 13
        case .normal: return 50
        case .bankAccount: return 50
        }
    }
    
    var validationMessage: String? {
        switch self {
        case .email: return "errorCode.email_invalid".localized()
        case .password: return "global.detail.passwordLimit_tips".localized()
        case .phone: return "register.error.mobile_error".localized()
        case .houseNumber: return "houseInvalid".localized()
        case .name, .postalCode: return "enterRequiredInfo".localized()
        case .cardMonth: return "monthInvalid".localized()
        case .cardName: return "cardNameInvalid".localized()
        case .cardNumber: return "cardInvalid".localized()
        case .cardYear: return "yearInvalid".localized()
        case .cvv: return "cvvInvalid".localized()
        case .taxId: return "taxIdValidation".localized()
        case .normal: return "Tips.can_not_empty".localized()
        case .bankAccount: return "Bank account number must be atleast 4 digits"
        }
    }
}
