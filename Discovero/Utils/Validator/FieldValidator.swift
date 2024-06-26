// Copyright © 2021 Minor. All rights reserved.

import Foundation

struct FieldValidator {
    
    let fieldType: FieldType
    
    init(fieldType: FieldType) {
        self.fieldType = fieldType
    }
    
    internal func isMinLength(text: String) -> Bool {
        guard let minCount = fieldType.minLength else { return true }
        return text.count >= minCount
    }
    
    internal func isMaxLength(text: String) -> Bool {
        guard let maxCount = fieldType.maxLength else { return true }
        return text.count <= maxCount
    }
    
    internal func isEmailValid(text: String) -> Bool {
        if fieldType == .email { return isValidEmail(text: text) }
        return true
    }
    
    internal func isPasswordValid(text: String) -> Bool {
        if fieldType == .password { return checkPasswordValidity(password: text) }
        return true
    }
    
    private func isValidEmail(text:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    internal func isValidCardName(text:String) -> Bool {
        let cardNameRegEx = "(?<! )[-a-zA-Z'`~. ]{2,24}"
        let cardNameTest = NSPredicate(format:"SELF MATCHES %@", cardNameRegEx)
        return cardNameTest.evaluate(with: text)
    }
    
    private func checkPasswordValidity(password: String) -> Bool {
        let passwordValue = password
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let capitalStringCheck = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = capitalStringCheck.evaluate(with: passwordValue)
        
        let smallLetterRegEx  = ".*[a-z]+.*"
        let smallStringCheck = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        let smallResult = smallStringCheck.evaluate(with: passwordValue)
        
        let numberRegEx  = ".*[0-9]+.*"
        let numberCheck = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberResult = numberCheck.evaluate(with: passwordValue)
        
        return numberResult && capitalResult && smallResult
    }
}




