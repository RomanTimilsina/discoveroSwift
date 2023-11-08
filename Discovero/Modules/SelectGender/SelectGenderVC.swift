//
//  SelectGenderVC.swift
//  Discovero
//
//  Created by admin on 08/11/2023.
//

import UIKit

class SelectGenderVC: UIViewController {
    
    var currentView = SelectGenderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onClickedSave = { [weak self] in
            guard let self else { return }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
}
