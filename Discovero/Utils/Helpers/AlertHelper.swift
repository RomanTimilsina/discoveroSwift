// Copyright © 2021 Minor. All rights reserved.

import UIKit

struct AlertMessage {
    
    static func showBasicAlert(on vc: UIViewController, message: String) {
        let alert = UIAlertController(title: AppConstants.appName, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok_mobile".localized(), style: .default))
        vc.present(alert, animated: true)
    }
    
    static func showBasicAlertWithCompletion(on vc: UIViewController, message: String, okPressed: @escaping () -> Void) {
        let alert = UIAlertController(title: AppConstants.appName, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok_mobile".localized(), style: .default) { _ in
            okPressed()
        }
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    static func showCustomAlert(on vc: UIViewController, _ title: String? = AppConstants.appName, message: String, firstBtnTitle: String, secondBtnTitle: String, optionStyle: UIAlertAction.Style = .destructive, secondButtonStyle: UIAlertAction.Style = .default, firstBtnPressed : (() -> Void)?, secondBtnPressed : (() -> Void)? ) {
        
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: firstBtnTitle, style: optionStyle) { _ in
            if let firstBtnPressed = firstBtnPressed {
                firstBtnPressed()
            }
        }
        
        let cancelAction = UIAlertAction(title: secondBtnTitle, style: secondButtonStyle) { _ in
            if let secondBtnPressed = secondBtnPressed {
                secondBtnPressed()
            }
        }
        
        alertContoller.addAction(okAction)
        alertContoller.addAction(cancelAction)
        
        vc.present(alertContoller, animated: true, completion: nil)
    }
}
