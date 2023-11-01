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
        currentView.onCloseClick = { [weak self] in
            guard let self = self else { return }
            onClosePicker?()
        }
        currentView.onOfferClick = { [weak self] in
            guard let self = self else { return }
            openCreateAdsOffer()
        }
        
        currentView.onLookingClick = { [weak self] in
            guard let self = self else { return }
            openCreateAdsLooking()
        }
    }
    
    private func openCreateAdsOffer() {

        if currentView.offerLabel.text == "Offer a Room" {
            let vc = CreateAdsVC()
            vc.currentView.setLabel(label: "Price per week", headerText: "Create Offer a Room Ads")
            gotoVC(vc: vc)
        } else if currentView.offerLabel.text == "Offer a Job" {
            let vc = CreateJobsAdsVC()
            vc.currentView.productTypeLabel.removeFromSuperview()
            vc.currentView.setLabel(label: "Salary", headerText: "Create Offer a Job Ads")
            
            vc.postPreview.currentView.postView.tubImage.isHidden = true
            vc.postPreview.currentView.postView.tubNumberLabel.isHidden = true
            vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
            vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
            vc.postPreview.currentView.postView.bedroomImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds: true)
            
            gotoVC(vc: vc)
        } else if currentView.offerLabel.text == "Sell Something" {
            let vc = CreateJobsAdsVC()
            vc.currentView.setLabel(label: "Price per item", headerText: " Create Sell Something Ads", selectorLabel: "No of Items")
            vc.currentView.JobTypeLabel.removeFromSuperview()
            vc.currentView.coverButton.removeFromSuperview()
            
            vc.postPreview.currentView.postView.bedroomImage.image = UIImage(named: "salesImage")

            vc.postPreview.currentView.postView.tubImage.removeFromSuperview()
            vc.postPreview.currentView.postView.tubNumberLabel.removeFromSuperview()
            vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
            vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()

            gotoVC(vc: vc)
        }
    }
    
    private func openCreateAdsLooking() {
        
        if currentView.lookingLabel.text == "Looking For Room" {
            let vc = CreateAdsVC()
            vc.currentView.setLabel(label: "Budget per week", headerText: "Create Looking a Room Ads")
            vc.currentView.propertyTypeLabel.isHidden = true
            gotoVC(vc: vc)
        } else if currentView.lookingLabel.text == "Looking For Job" {
            let vc = CreateJobsAdsVC()
            vc.currentView.productTypeLabel.removeFromSuperview()
            vc.currentView.selector.isHidden = true
            vc.currentView.selector.constraintHeight(constant: 0)
            vc.currentView.setLabel(label: "Expected Salary", headerText: "Create Looking a Job Ads")
            vc.postPreview.currentView.postView.tubImage.isHidden = true
            vc.postPreview.currentView.postView.tubNumberLabel.isHidden = true
            vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
            vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
            vc.postPreview.currentView.postView.bedroomImage = UIImageView(image: UIImage(named: "jobsImage"), contentMode: .scaleAspectFit, clipsToBounds: true)
            gotoVC(vc: vc)
        }else if currentView.lookingLabel.text == "Looking For Something" {
            let vc = CreateJobsAdsVC()
            vc.currentView.setLabel(label: " Budget Price per item", headerText: "Create Looking For Something Ads", selectorLabel: "No of items")
            vc.currentView.JobTypeLabel.removeFromSuperview()
            vc.currentView.coverButton.removeFromSuperview()

            vc.postPreview.currentView.postView.bedroomImage.image = UIImage(named: "salesImage")

            vc.postPreview.currentView.postView.tubImage.removeFromSuperview()
            vc.postPreview.currentView.postView.tubNumberLabel.removeFromSuperview()
            vc.postPreview.currentView.postView.garageImage.removeFromSuperview()
            vc.postPreview.currentView.postView.garageNumberLabel.removeFromSuperview()
            
            gotoVC(vc: vc)
        }
    }
    
    func gotoVC(vc: UIViewController) {
        let navigationController = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
    
    override func loadView() {
        view = currentView
    }
}
