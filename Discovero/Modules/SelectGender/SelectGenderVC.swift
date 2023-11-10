//
//  SelectGenderVC.swift
//  Discovero
//
//  Created by admin on 08/11/2023.
//

import UIKit

class SelectGenderVC: UIViewController {
    
    var currentView = SelectGenderView()
    var onGenderClick: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onClickedSave = { [weak self] selectedGender in
            guard let self else { return }
            onGenderClick?(selectedGender)
            
            navigationController?.popViewController(animated: true)

        }
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
}

