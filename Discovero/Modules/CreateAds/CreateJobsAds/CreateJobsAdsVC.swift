//
//  CreateJobsAdsVC.swift
//  Discovero
//
//  Created by admin on 01/11/2023.
//

import UIKit

class CreateJobsAdsVC: UIViewController {
    
    let currentView = CreateJobsAdsView()
    let postPreview = PostPreviewVC()

    var usersData: UserData?
    var isItJob: Bool?

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
        
        currentView.onNextClick = { [weak self]  in
            guard let self = self else { return }
            gotoPostPreviewVC()
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true)
        }
        
        func gotoPostPreviewVC() {
            guard let isItJob else { return }
            if isItJob {
                let jobModel = JobModel(adsTitle: currentView.titleView.textField.text ?? "", description: currentView.descriptionsView.textField.text ?? "", salary: Double(currentView.salaryTextField.text ?? "0.0") ?? 0.0, country: currentView.countryName ?? "", state: currentView.stateName ?? "", suburb: currentView.suburbName ?? "", noOfPostion: currentView.selector.count, jobType: currentView.JobTypeLabel.sideTitle.text ?? "")
                postPreview.currentView.postView.configureData( roomData: nil, jobData: jobModel, buyAndSellData: nil)
            } else {
                let buyAndSell = BuySellModel(adsTitle: currentView.titleView.textField.text ?? "", description: currentView.descriptionsView.textField.text ?? "", price:  Double(currentView.salaryTextField.text ?? "0.0") ?? 0.0, country: currentView.countryName ?? "", state: currentView.stateName ?? "", suburb: currentView.suburbName ?? "", noOfItems: currentView.selector.count, productTypeLabel: currentView.productTypeLabel.sideTitle.text ?? "")
                postPreview.currentView.postView.configureData( roomData: nil, jobData: nil, buyAndSellData: buyAndSell)
            }
            
            navigationController?.pushViewController(postPreview, animated: true)

        }
        
        func gotoLocationFilterVC() {
            let locationFilterVC = LocationFilterVC()
            locationFilterVC.userData = usersData
            
            navigationController?.pushViewController(locationFilterVC, animated: true)
            
            locationFilterVC.onSaveClick = { [weak self] country, state, suburb in
                guard let self else { return }
                currentView.locationLabel.subTitle.text = "\(country ?? ""), \(state ?? ""), \(suburb ?? "")"
                currentView.countryName = country
                currentView.stateName = state
                currentView.suburbName = suburb
            }
        }
    }
    
    override func loadView() {
        view = currentView
    }
}
