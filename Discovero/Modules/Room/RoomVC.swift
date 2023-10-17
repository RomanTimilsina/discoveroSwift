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
    
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.currentView.bodyView.roomOfferView.isHidden = false
        self.currentView.bodyView.roomWantedView.isHidden = true
        self.currentView.bodyView.emptyStackView.isHidden = true
    }
    
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
        currentView.headerTab.handleOffer = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.roomOfferView.isHidden = false
            self.currentView.bodyView.roomWantedView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true

        }
        
        currentView.headerTab.handleWanted = { [weak self] in
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
