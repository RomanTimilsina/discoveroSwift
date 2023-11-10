//
//  CreateAdsVC.swift
//  Discovero
//
//  Created by admin on 30/10/2023.
//

import UIKit

class CreateAdsVC: UIViewController {
    
    var postModel = PostModel()
    let postPreviewVC = PostPreviewVC()
    let currentView = CreateAdsView()
    var timer: Timer?

    var usersData: UserData?

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
        
        currentView.onNextClick = { [weak self] postModel in
            guard let self = self else { return }
            checkValidation(postModel: postModel)
            postPreviewVC.currentView.postView.configureData(roomData: postModel)
        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
    
    override func loadView() {
        view = currentView
    }
    
    func checkValidation(postModel: PostModel) {
        let validationOffer = OfferPageValidation(caption: postModel.caption, description: postModel.description, price: postModel.price, country: postModel.country, state: postModel.state, property: postModel.propertyType)
        
        switch validationOffer {
        case .captionError, .descriptionError, .priceError, .countryError, .stateError, .propertyError:
            let alertController = UIAlertController(title: "Errors Alert", message: validationOffer.title, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        case .noError:
            navigationController?.pushViewController(postPreviewVC, animated: true)
        }
    }
}

// MARK: push to VC
extension CreateAdsVC {
    func gotoLocationFilterVC() {
        let locationFilterVC = LocationFilterVC()
        locationFilterVC.userData = usersData
        
        navigationController?.pushViewController(locationFilterVC, animated: true)
        
        locationFilterVC.onSaveClick = { [weak self] locationData in
            guard let self else { return }
            currentView.locationLabel.subTitle.text = "\(locationData[0]), \(locationData[1] ), \(locationData[2] )"
            currentView.countryName = locationData[0]
            currentView.stateName = locationData[1]
            currentView.suburbName = locationData[2]
        }
    }
}


enum OfferPageValidation {
    case captionError
    case descriptionError
    case priceError
    case countryError
    case stateError
    case propertyError
    case noError
    
    var title: String {
        switch self {
        case .captionError: return "You haven't filled title"
        case .descriptionError: return "You haven't filled description"
        case .priceError: return "You haven't set price"
        case .countryError: return "You haven't selected country"
        case .stateError: return "You haven't selected state"
        case .propertyError: return "You haven't selected property"
        case .noError: return ""
        }
    }

    init(caption: String = "", description: String = "", price: Double = 0.0, country: String = "", state: String = "", property: String = AppConstants.tapToChoose) {
        
        switch true {
        case caption.isEmpty:
            self = .captionError
        case description.isEmpty:
            self = .descriptionError
        case price == 0.0:
            self = .priceError
        case country.isEmpty:
            self = .countryError
        case state.isEmpty:
            self = .stateError
        case property == AppConstants.tapToChoose:
            self = .propertyError
        default:
            self = .noError
        }
    }
}
