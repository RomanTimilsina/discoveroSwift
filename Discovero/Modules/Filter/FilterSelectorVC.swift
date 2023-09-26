//
//  FilterVC.swift
//  Discovero
//
//  Created by Mac on 20/09/2023.
//

import UIKit

class FilterSelectorVC: UIViewController {

    let currentView = FilterSelectorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = currentView
    }
}
