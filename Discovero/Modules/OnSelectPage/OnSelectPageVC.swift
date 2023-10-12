//
//  OnSelectPageVC.swift
//  Discovero
//
//  Created by Mac on 19/09/2023.
//

import UIKit

class OnSelectPageVC: UIViewController {
    
    let currentView = OnSelectPageView()
    
    override func viewWillAppear(_ animated: Bool) {
        currentView.handleToggleButtonTap = { [weak self] isShowLess, adsHeight in
            guard let self = self else { return }
            if isShowLess  {
                self.currentView.showToggleButton.setTitle("Read More", for: .normal)
                self.currentView.adDesciptionLabel.text = "\(currentView.adDescritionText.prefix(200))..."
            } else {
                self.currentView.showToggleButton.setTitle("Show Less", for: .normal)
                self.currentView.adDesciptionLabel.text = currentView.adDescritionText
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        if currentView.adDescritionText.count < 199 {
            currentView.showToggleButton.isHidden = true
        }
    }
    
    override func loadView() {
        view = currentView
    }
}
