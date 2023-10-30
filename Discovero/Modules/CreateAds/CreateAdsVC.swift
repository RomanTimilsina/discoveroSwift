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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.locationLabel.profileTap = { [weak self] text in
            guard let self = self else { return }
            gotoLocationFilterVC()
        }
    }
    
    func gotoLocationFilterVC() {
        let locationFilterVC = LocationFilterVC()
        locationFilterVC.userData = usersData
        
        navigationController?.pushViewController(locationFilterVC, animated: true)
        
        locationFilterVC.onSaveClick = { [weak self] locationFilterModel in
            guard let self else { return }
            currentView.locationLabel.subTitle.text = "\(locationFilterModel.countryName ?? ""), \(locationFilterModel.stateName ?? "")"
            currentView.countryName = locationFilterModel.countryName
            currentView.stateName = locationFilterModel.stateName
        }
    }
    override func loadView() {
        view = currentView
    }
}
