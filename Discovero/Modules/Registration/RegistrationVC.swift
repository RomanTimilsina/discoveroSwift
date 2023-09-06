//
//  PersonalInfoVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class RegistrationVC: UIViewController {
    
    let registrationView = RegistrationView()
    let items = ["Option 1", "Option 2", "Option 3", "Option 4"]

    lazy var countryPicker = DIPickerVC()
    
    override func loadView() {
        super.loadView()
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.gray900
        
        loginEvents()
    }
    
    func loginEvents() {
        registrationView.openPicker = {[weak self] in
            guard let self = self else {return}
            self.openCountryPicker()
        }
        
        registrationView.closePicker = {[weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        
        registrationView.headerView.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
    }
    
    func openCountryPicker() {
        if let sheet = countryPicker.sheetPresentationController{
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return 261
                    },
                    .large()
                ]
            } else {
                sheet.detents = [.medium()]
            }
        }
        present(countryPicker, animated: true)
    }
}

extension RegistrationVC {

}
