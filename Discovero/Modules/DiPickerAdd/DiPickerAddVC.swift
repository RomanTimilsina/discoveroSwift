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
        
        currentView.onRoomCLick = { [weak self] in
            guard let self else { return }
            openRoomPicker()
        }
        
        currentView.onJobClick = { [weak self] in
            guard let self else { return }
            openJobPicker()
        }
        
        currentView.onBuyAndSellClick = { [weak self] in
            guard let self else { return }
            openBuyAndSellPicker()
        }
        
        bottomPicker.onClosePicker = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        func openRoomPicker() {
            let bottomPicker = BottomSheetPickerVC()
            
            bottomPicker.currentView.setLabel(offerText: "Offer a Room", lookingText: "Looking For Room")
            bottomPicker.modalPresentationStyle = .automatic
            if let sheet = bottomPicker.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
                sheet.detents = [.large(), .custom { _ in return 150}]
                sheet.delegate = self
            }
            present(bottomPicker, animated: true, completion: nil)
        }
        
        
        func openJobPicker(){
            bottomPicker.modalPresentationStyle = .automatic
            
            bottomPicker.currentView.setLabel(offerText: "Offer a Job", lookingText: "Looking For Job")
            
            if let sheet = bottomPicker.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
                sheet.detents = [.large(), .custom { _ in return 150}]
                sheet.delegate = self
            }
            present(bottomPicker, animated: true, completion: nil)
        }
        
        func openBuyAndSellPicker(){
            bottomPicker.modalPresentationStyle = .automatic
            
            bottomPicker.currentView.setLabel(offerText: "Sell Something", lookingText: "Looking For Something")
            
            if let sheet = bottomPicker.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
                sheet.detents = [.large(), .custom { _ in return 150}]
                sheet.delegate = self
            }
            present(bottomPicker, animated: true, completion: nil)
        }
    }
        
    override func loadView() {
        view = currentView
    }
}
