//
//  CreateAdsVC.swift
//  Discovero
//
//  Created by admin on 30/10/2023.
//

import UIKit

class CreateAdsVC: UIViewController {
    
    let currentView = CreateAdsView()
    
    var usersData: UserData?
    
    let postPreview = PostPreviewVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.locationLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            gotoLocationFilterVC()
        }
        
        currentView.onNextClick = { [weak self] in
            guard let self = self else { return }
            
            gotoPostPreviewVC()
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true)
        }
}
    
    override func loadView() {
        view = currentView
    }
}

// MARK: push to VC
extension CreateAdsVC {
    func gotoPostPreviewVC() {
        
        let postModel = PostModel(name: "", country: currentView.countryName ?? "", state: currentView.stateName ?? "", suburb: currentView.suburbName ?? "",caption: currentView.titleView.textField.text ?? "", description: currentView.descriptionsView.textField.text ?? "", propertyType: currentView.propertyTypeLabel.sideTitle.text ?? "", price: Double(currentView.priceTextField.text ?? "0.0") ?? 0.0, noOfBedroom: currentView.noOfBedrooms.count, noOfBathroom: currentView.noOfBathrooms.count, noOfParkings: currentView.noOfParkings.count, isAnonymous: false)
        
        postPreview.currentView.postView.configureData(roomData: postModel, jobData: nil, buyAndSellData: nil)

        navigationController?.pushViewController(postPreview, animated: true)
    }
    
    func gotoLocationFilterVC() {
        let locationFilterVC = LocationFilterVC()
        locationFilterVC.userData = usersData
        
        navigationController?.pushViewController(locationFilterVC, animated: true)
        
        locationFilterVC.onSaveClick = { [weak self] country, state, suburb in
            guard let self else { return }
            currentView.locationLabel.subTitle.text = "\(country ), \(state ), \(suburb )"
            currentView.countryName = country
            currentView.stateName = state
            currentView.suburbName = suburb
        }
    }
}
