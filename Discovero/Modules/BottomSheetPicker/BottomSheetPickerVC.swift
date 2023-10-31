//
//  BottomSheetPickerVC.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class BottomSheetPickerVC : UIViewController {
    
    let currentView = BottomSheetPickerView()
    
    var onClosePicker: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
//        currentView.onCloseClick = { [weak self] in
//            guard let self = self else { return }
//            onClosePicker?()
//        }
        currentView.onOfferClick = { [weak self] in
            guard let self = self else { return }
            openCreateAdsOffer()
//            navigationController?.pushViewController(CreateAdsVC(), animated: true)
        }
        
        currentView.onLookingClick = { [weak self] in
            guard let self = self else { return }
            openCreateAdsLooking()
        }
    }
    
    private func openCreateAdsOffer() {
        let vc = CreateAdsVC()
        let navigationController = UINavigationController(rootViewController: vc)

        vc.currentView.setLabel(label: "Price per week")
        vc.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
    
    private func openCreateAdsLooking() {
        let vc = CreateAdsVC()
        vc.currentView.setLabel(label: "Budget per week")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    override func loadView() {
        view = currentView
    }
}
