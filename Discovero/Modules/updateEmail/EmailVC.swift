//
//  EmailVC.swift
//  Discovero
//
//  Created by Mac on 12/09/2023.
//

import UIKit

class EmailVC: UIViewController {
    
    var onTitle: String?
    var onPlaceholder: String?

    let email = EmailView(title: "", placeholder: "")
    
     func viewWillAppear() {
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        email.Field.titleLabel.text = "What's your \(onTitle ?? "")"
        email.Field.textField.placeholder = onPlaceholder ?? ""
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        
        loginEvents()
        
    }
    
    override func loadView() {
        view = email
    }
    
    func loginEvents() {
        email.header.onClose = {[weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        }
    }
}
