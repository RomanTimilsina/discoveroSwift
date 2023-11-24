//
//  MarketVC.swift
//  Discovero
//
//  Created by Mac on 24/11/2023.
//

import UIKit
import Combine

class MarketVC : UIViewController{
    
    let currentView = MarketView()
    
    var buyVC:  BuyVC?
    var sellVC : SellVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupChildController()
        observeViewEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupChildController(){
        buyVC = BuyVC()
        guard let buyVC = buyVC else { return }
        add(buyVC, innerView: currentView.bodyView.buyView)
        buyVC.view.fillSuperview()
        
        sellVC = SellVC()
        guard let sellVC = sellVC else { return }
        add(sellVC, innerView: currentView.bodyView.sellView)
        sellVC.view.fillSuperview()
    }
    
    func observeViewEvents() {
        currentView.headerTab.onOfferClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.buyView.isHidden = false
            self.currentView.bodyView.sellView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
        }
        
        currentView.headerTab.onWantedClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.sellView.isHidden = false
            self.currentView.bodyView.buyView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
        }
    }
    
    override func loadView() {
        view = currentView
    }
}

