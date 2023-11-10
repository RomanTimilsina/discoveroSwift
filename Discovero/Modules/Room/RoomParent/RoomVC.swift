//
//  RoomVC.swift
//  Discovero
//
//  Created by Mac on 17/10/2023.
//

import UIKit
import Combine

class RoomVC : UIViewController{
    
    let currentView = RoomView()
    
    var roomOfferVC: RoomOfferVC?
    var roomWantedVC : RoomWantedVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
//        FireStoreDatabaseHelper().getUserDataFromDefaults()
        
        self.currentView.bodyView.emptyStackView.isHidden = true
//        self.currentView.headerTab.isHidden = true
        self.currentView.notification.isHidden = false
        
        setupChildController()
        observeViewEvents()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupChildController(){
        roomOfferVC = RoomOfferVC()
        guard let roomOfferVC = roomOfferVC else { return }
        add(roomOfferVC, innerView: currentView.bodyView.roomOfferView)
        roomOfferVC.view.fillSuperview()


        roomWantedVC = RoomWantedVC()
        guard let roomWantedVC = roomWantedVC else { return }
        add(roomWantedVC, innerView: currentView.bodyView.roomWantedView)
        roomWantedVC.view.fillSuperview()
    }
    
    func observeViewEvents() {
        currentView.headerTab.onOfferClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.roomOfferView.isHidden = false
            self.currentView.bodyView.roomWantedView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
        }
        
        currentView.notification.handleClose = {[weak self] in
            guard let self else {return}
            currentView.notification.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
            self.currentView.headerTab.isHidden = false
        }

        
        currentView.headerTab.onWantedClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.emptyStackView.isHidden = true
            self.currentView.bodyView.roomOfferView.isHidden = true
            self.currentView.bodyView.roomWantedView.isHidden = false
        }
    }
    
    override func loadView() {
        view = currentView
    }
}
