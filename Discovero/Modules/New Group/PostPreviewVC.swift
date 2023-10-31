//
//  PostPreviewVC.swift
//  Discovero
//
//  Created by admin on 31/10/2023.
//

import UIKit

class PostPreviewVC: UIViewController {
    
    let currentView = PostPreviewView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
        
    }
}
