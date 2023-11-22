//
//  File.swift
//  Discovero
//
//  Created by admin on 22/11/2023.
//

import UIKit

class MyFavoritesVC : UIViewController {
     
    let currentView = MyFavoritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    
        setupViewEvents()
    }
    
    func setupViewEvents() {
        
        currentView.headerView.onClose = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
}
