//
//  PersonalInfoVC.swift
//  Discovero
//
//  Created by Mac on 05/09/2023.
//

import UIKit

class RegistrationVC: UIViewController, UISheetPresentationControllerDelegate {
    let registrationView = RegistrationView()
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
        registrationView.openPicker = { [weak self] in
            guard let self = self else { return }
            self.openCountryPicker()
        }
        
        countryPicker.closePicker = { [weak self] in
            guard let self = self else { return }
            registrationView.backgroundColor = UIColor.white.withAlphaComponent(0)
            self.dismiss(animated: true, completion: nil)
        }
        
        registrationView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func openCountryPicker() {
        if let sheet = countryPicker.sheetPresentationController {
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
            
            // Set the sheet's delegate to handle dismissal
            sheet.delegate = self
        }
        registrationView.backgroundColor = UIColor.white.withAlphaComponent(0.38)
        
        present(countryPicker, animated: true)
    }
    
    // MARK: - UISheetPresentationControllerDelegate
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Change the background color when the sheet is dismissed
        registrationView.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
}
