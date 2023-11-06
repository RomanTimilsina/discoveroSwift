//
//  DiPickerAddVC.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit
import Foundation

class DiPickerAddVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = DiPickerAddView()
    
    var onClosePicker: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.onRoomCLick = { [weak self] in
            guard let self else { return }
            openPicker(offer: .offerRoom, looking: .lookingForRoom)
        }
        
        currentView.onJobClick = { [weak self] in
            guard let self else { return }
            openPicker(offer: .offerJob, looking: .lookingForJob)
        }
        
        currentView.onBuyAndSellClick = { [weak self] in
            guard let self else { return }
            openPicker(offer: .sellSomething, looking: .buySomething)
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
    func openPicker(offer: AdsOfferPage,  looking: AdsLookingPage) {
        DataContainer.shared.selectedAdsOfferPage = offer
        DataContainer.shared.selectedAdsLookingPage = looking
        
        let bottomPickerVC = BottomSheetPickerVC()

        bottomPickerVC.currentView.setLabel(offerText: DataContainer.shared.selectedAdsOfferPage?.title ?? "",
                                            lookingText: DataContainer.shared.selectedAdsLookingPage?.title ?? ""
        )
        bottomPickerVC.modalPresentationStyle = .automatic
        if let sheet = bottomPickerVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.large(), .custom { _ in return 180}]
            sheet.delegate = self
        }
        present(bottomPickerVC, animated: true, completion: nil)
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
