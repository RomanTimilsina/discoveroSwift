//
//  JobVc.swift
//  Discovero
//
//  Created by admin on 03/11/2023.
//

import UIKit
import Combine

class JobVC : UIViewController{
    
    let currentView = JobView()
    
    var jobOfferVC:  JobOfferVC?
    var jobWantedVC : JobWantedVC?

    var roomOfferCount: Int?
    var roomWantedCount: Int?
    
    override func viewWillAppear(_ animated: Bool) {
//        self.currentView.bodyView.jobOfferView.isHidden = false
//        self.currentView.bodyView.jobWantedView.isHidden = true
//        self.currentView.bodyView.emptyStackView.isHidden = true
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
        jobOfferVC = JobOfferVC()
        guard let jobOfferVC = jobOfferVC else { return }
        add(jobOfferVC, innerView: currentView.bodyView.jobOfferView)
        jobOfferVC.view.fillSuperview()
        
        jobWantedVC = JobWantedVC()
        guard let jobWantedVC = jobWantedVC else { return }
        add(jobWantedVC, innerView: currentView.bodyView.jobWantedView)
        jobWantedVC.view.fillSuperview()
    }
    
    func observeViewEvents() {
        currentView.headerTab.onOfferClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.jobOfferView.isHidden = false
            self.currentView.bodyView.jobWantedView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
        }
        
        currentView.headerTab.onWantedClicked = { [weak self] in
            guard let self else { return }
            self.currentView.bodyView.jobWantedView.isHidden = false
            self.currentView.bodyView.jobOfferView.isHidden = true
            self.currentView.bodyView.emptyStackView.isHidden = true
        }
    }
    
    override func loadView() {
        view = currentView
    }
}

