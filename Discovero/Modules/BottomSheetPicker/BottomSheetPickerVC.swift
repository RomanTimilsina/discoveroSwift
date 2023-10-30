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
            navigationController?.pushViewController(CreateAdsVC(), animated: true)
        }
    }
    override func loadView() {
        view = currentView
    }
}
