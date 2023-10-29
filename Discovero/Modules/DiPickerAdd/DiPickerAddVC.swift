//
//  DiPickerAddVC.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class DiPickerAddVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = DiPickerAddView()
    
    var onClosePicker: (() -> Void)?
    
    let bottomPicker = BottomSheetPickerVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
//        currentView.onCloseClick = { [weak self] in
//            guard let self = self else { return }
//            onClosePicker?()
//        }
        
        currentView.onClickedRoom = { [weak self] in
            guard let self else { return }
            openBottomPicker()
        }
    
    func openBottomPicker(){
        bottomPicker.modalPresentationStyle = .automatic
        if let sheet = bottomPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large(), .custom { _ in return 200}]
            sheet.delegate = self
        }
        present(bottomPicker, animated: true, completion: nil)
    }
        
    }
    override func loadView() {
        view = currentView
    }
}
