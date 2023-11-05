//
//  BottomSheetPickerVC.swift
//  Discovero
//
//  Created by admin on 29/10/2023.
//

import UIKit

class BottomSheetPickerVC : UIViewController {
    
    let currentView = BottomSheetPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.onCloseClick = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true, completion: nil)
        }
        
        currentView.onOfferClick = { [weak self] in
            guard let self = self else { return }
            
            if let selectedOfferPage = DataContainer.shared.selectedAdsOfferPage {
                switch selectedOfferPage {
                case .offerRoom:
                    openOfferRoom()
                case .offerJob:
                    openOfferJob()
                case .sellSomething:
                    openSellStuff()
                }
            }
        }
        
        currentView.onLookingClick = { [weak self] in
            guard let self = self else { return }
            
            if let selectedLookingForPage = DataContainer.shared.selectedAdsLookingPage {
                switch selectedLookingForPage {
                case .lookingForRoom:
                    openLookingForRoom()
                case .lookingForJob:
                    openLookingForJob()
                case .buySomething:
                    openBuySomething()
                }
            }
        }
    }
    
    override func loadView() {
        view = currentView
    }
}

// MARK: - push to pages
extension BottomSheetPickerVC {
    
    func gotoVC(vc: UIViewController) {
        let navigationController = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
    
    func openLookingForRoom() {
        let vc = CreateAdsVC()
        vc.currentView.setLabel(label: "Budget per week", headerText: "Create Looking a Room Ads")
        vc.postPreviewVC.currentView.postView.textView.removeFromSuperview()
        vc.postPreviewVC.currentView.postView.announcmentLikeButton.removeFromSuperview()
        gotoVC(vc: vc)
    }
    
    func openLookingForJob() {
        let vc = CreateJobsAdsVC()
        vc.currentView.setLabel(label: "Expected Salary", headerText: "Create Looking a Job Ads")
        vc.currentView.productTypeLabel.removeFromSuperview()
        vc.currentView.selector.isHidden = true
        vc.currentView.selector.constraintHeight(constant: 0)
        
        vc.postPreview.currentView.postView.bedroomImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds: true)
        vc.postPreview.currentView.postView.tubImage.isHidden = true
        vc.postPreview.currentView.postView.tubNumberLabel.isHidden = true
        vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
        vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.textView.removeFromSuperview()
        vc.postPreview.currentView.postView.announcmentLikeButton.removeFromSuperview()
        
        vc.isItJob = true
        
        gotoVC(vc: vc)
    }
    
    func openBuySomething() {
        let vc = CreateJobsAdsVC()
        vc.currentView.setLabel(label: " Budget Price per item", headerText: "Create Looking For Something Ads", selectorLabel: "No of items")
        vc.currentView.JobTypeLabel.removeFromSuperview()
        vc.currentView.coverButton.removeFromSuperview()
        
        vc.postPreview.currentView.postView.bedroomImage.image = UIImage(named: "salesImage")
        vc.postPreview.currentView.postView.tubImage.removeFromSuperview()
        vc.postPreview.currentView.postView.tubNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
        vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.textView.removeFromSuperview()
        vc.postPreview.currentView.postView.announcmentLikeButton.removeFromSuperview()
        
        vc.isItJob = false
        
        gotoVC(vc: vc)
    }
    
    
    func openOfferRoom() {
        let vc = CreateAdsVC()
        vc.currentView.setLabel(label: "Price per week", headerText: "Create Offer a Room Ads")
        vc.postPreviewVC.currentView.postView.textView.removeFromSuperview()
        vc.postPreviewVC.currentView.postView.announcmentLikeButton.removeFromSuperview()
        gotoVC(vc: vc)
    }
    
    func openOfferJob() {
        let vc = CreateJobsAdsVC()
        vc.currentView.setLabel(label: "Salary", headerText: "Create Offer a Job Ads")
        vc.currentView.productTypeLabel.removeFromSuperview()
        
        vc.postPreview.currentView.postView.bedroomImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds: true)
        vc.postPreview.currentView.postView.tubImage.isHidden = true
        vc.postPreview.currentView.postView.tubNumberLabel.isHidden = true
        vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
        vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.textView.removeFromSuperview()
        vc.postPreview.currentView.postView.announcmentLikeButton.removeFromSuperview()
        
        vc.isItJob = true
        gotoVC(vc: vc)
    }
    
    func openSellStuff() {
        let vc = CreateJobsAdsVC()
        vc.currentView.setLabel(label: "Price per item", headerText: " Create Sell Something Ads", selectorLabel: "No of Items")
        vc.currentView.JobTypeLabel.removeFromSuperview()
        vc.currentView.coverButton.removeFromSuperview()
        
        vc.postPreview.currentView.postView.bedroomImage.image = UIImage(named: "salesImage")
        
        vc.postPreview.currentView.postView.tubImage.removeFromSuperview()
        vc.postPreview.currentView.postView.tubNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
        vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
        vc.postPreview.currentView.postView.textView.removeFromSuperview()
        vc.postPreview.currentView.postView.announcmentLikeButton.removeFromSuperview()

        vc.isItJob = false
        
        gotoVC(vc: vc)
    }
}




