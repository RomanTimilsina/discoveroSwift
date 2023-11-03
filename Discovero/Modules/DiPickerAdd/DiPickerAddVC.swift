//
//  DiPickerAddVC.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit
import Foundation

enum AdsOfferPage {
    case offerRoom
    case offerJob
    case sellSomething
    
    var title: String {
        switch self {
        case .offerRoom: return "Offer a Room"
        case .offerJob: return "Offer a Job"
        case .sellSomething: return "Sell Something"
        }
    }
}

enum AdsLookingPage {
    case lookingForRoom
    case lookingForJob
    case buySomething
    
    var title: String {
        switch self {
        case .lookingForRoom: return "Looking For Room"
        case .lookingForJob: return "Looking For Job"
        case .buySomething: return "Looking For Something"
        }
    }
}

class DataContainer {
    static let shared = DataContainer()
    
    var selectedAdsOfferPage: AdsOfferPage?
    var selectedAdsLookingPage: AdsLookingPage?

    private init() { }
}

class DiPickerAddVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = DiPickerAddView()
    let bottomPicker = BottomSheetPickerVC()

    var onClosePicker: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
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
        
        currentView.onAnnouncementClick = { [weak self] in
            guard let self else { return }
            gotoCreateAnnouncement()
        }
    }
    
    override func loadView() {
        view = currentView
    }
}

// MARK: - Open respective pages once clicked
extension DiPickerAddVC {
    func openRoomPicker() {
        let bottomPicker = BottomSheetPickerVC()
        DataContainer.shared.selectedAdsOfferPage = .offerRoom
        DataContainer.shared.selectedAdsLookingPage = .lookingForRoom

        bottomPicker.currentView.setLabel(offerText: DataContainer.shared.selectedAdsOfferPage?.title ?? "", lookingText: DataContainer.shared.selectedAdsLookingPage?.title ?? "")
        bottomPicker.modalPresentationStyle = .automatic
        if let sheet = bottomPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large(), .custom { _ in return 150}]
            sheet.delegate = self
        }
        present(bottomPicker, animated: true, completion: nil)
    }
    
    func openJobPicker() {
        bottomPicker.modalPresentationStyle = .automatic
        
        DataContainer.shared.selectedAdsOfferPage = .offerJob
        DataContainer.shared.selectedAdsLookingPage = .lookingForJob
        
        bottomPicker.currentView.setLabel(offerText: DataContainer.shared.selectedAdsOfferPage?.title ?? "", lookingText: DataContainer.shared.selectedAdsLookingPage?.title ?? "")

        if let sheet = bottomPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large(), .custom { _ in return 150}]
            sheet.delegate = self
        }
        present(bottomPicker, animated: true, completion: nil)
    }
    
    func openBuyAndSellPicker() {
        bottomPicker.modalPresentationStyle = .automatic
        
        DataContainer.shared.selectedAdsOfferPage = .sellSomething
        DataContainer.shared.selectedAdsLookingPage = .buySomething
        
        bottomPicker.currentView.setLabel(offerText: DataContainer.shared.selectedAdsOfferPage?.title ?? "", lookingText: DataContainer.shared.selectedAdsLookingPage?.title ?? "")

        if let sheet = bottomPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large(), .custom { _ in return 150}]
            sheet.delegate = self
        }
        
        present(bottomPicker, animated: true, completion: nil)
    }
    
    func gotoCreateAnnouncement() {
        let vc = CreateAnnouncmentVC()
        
        let navigationController = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .overFullScreen
        
        vc.postPreview.currentView.postView.callStack.removeFromSuperview()
        vc.postPreview.currentView.postView.likeButton.removeFromSuperview()
        present(navigationController, animated: true)
    }
}
