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
        
        currentView.onNextClick = { [weak self] jobModel, buyAndSell  in
            guard let self = self else { return }
            guard let isItJob else { return }
            if isItJob {
                postPreview.currentView.postView.configureData(jobData: jobModel)
            }else{
                postPreview.currentView.postView.configureData(buyAndSellData: buyAndSell)
            }
            gotoPostPreviewVC(jobModel: jobModel, buyAndSell: buyAndSell)

        }
        
        currentView.headerView.onClose = { [weak self] in
            guard let self = self else { return }
            dismiss(animated: true)
        }
        func gotoPostPreviewVC(jobModel: JobModel, buyAndSell: BuySellModel) {
            guard let isItJob else { return }
            if isItJob {
                let checkValidiationJob = checkValidationJobs(title: jobModel.adsTitle, description: jobModel.description, salary: jobModel.salary, salaryType: jobModel.salarySideTitle, country: jobModel.country, state: jobModel.state, jobType: jobModel.jobType)
                
                switch checkValidiationJob{
                case .title, .description,.salary, .salarytype, .country, .state, .jobType:
                    let alertController = UIAlertController(title: "Errors Alert", message: checkValidiationJob.errorMessages, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                    alertController.addAction(action)
                    present(alertController, animated: true, completion: nil)
                case .allfieldfill:
                    navigationController?.pushViewController(postPreview, animated: true)
                }
          } else {
              let checkValidiationBuySell = checkValidationBuyAndSell(title: buyAndSell.adsTitle, description: buyAndSell.description, price: buyAndSell.price, country: buyAndSell.country, state: buyAndSell.state, productType: buyAndSell.productTypeLabel)
              
              switch checkValidiationBuySell{
              case .title, .description,.price, .country, .state, .productType:
                  let alertController = UIAlertController(title: "Errors Alert", message: checkValidiationBuySell.errorMessages, preferredStyle: .alert)
                  let action = UIAlertAction(title: "OK", style: .default) { (action) in
                  }
                  alertController.addAction(action)
                  present(alertController, animated: true, completion: nil)
              case .allfieldfill:
                  navigationController?.pushViewController(postPreview, animated: true)
              }

            }
        }
        
        func gotoLocationFilterVC() {
            let locationFilterVC = LocationFilterVC()
            locationFilterVC.userData = usersData
            
            navigationController?.pushViewController(locationFilterVC, animated: true)
            
            locationFilterVC.onSaveClick = { [weak self] locationData in
                guard let self else { return }
                currentView.locationLabel.subTitle.text = stringList(locationData)
                currentView.countryName = locationData[0]
                currentView.stateName = locationData[1]
                currentView.suburbName = locationData[2]
                currentView.streetName = locationData[3]
                currentView.suburbName = locationData[4]
                currentView.streetName = locationData[5]
            }
        }
        
        func stringList(_ stringArray: [String]) -> String {
            var text = ""
            var arr = stringArray.reversed()
            var nonEmptyArray = stringArray.filter{ !$0.isEmpty}
            
            for (index, item) in nonEmptyArray.enumerated() {
                text += "\(item == "" || index == 0  ? "" : ", ") \(item)"
            }
            return text
        }
    }
    
    override func loadView() {
        view = currentView
    }
}

enum checkValidationJobs {
    case title
    case description
    case salary
    case salarytype
    case country
    case state
    case jobType
    case allfieldfill
    
    var errorMessages: String {
        switch self {
        case .title: return "Title can't be empty"
        case .description: return "Description can't be empty"
        case .salary: return "Salary can't be empty"
        case .salarytype: return "Salary basis can't be empty"
        case .country: return "Country can't be empty"
        case .state: return "States can't be empty"
        case .jobType: return "Choose Job type"
        case .allfieldfill: return ""
        }
    }
    
    init(title: String, description: String, salary: Double, salaryType: String, country: String, state: String, jobType: String){
        switch true{
        case title.isEmpty: self = .title
        case description.isEmpty: self = .description
        case salary == 0.0: self = .salary
        case salaryType.isEmpty: self = .salarytype
        case country.isEmpty: self = .country
        case state.isEmpty: self = .state
        case jobType == AppConstants.tapToChoose: self = .jobType
        default: self = .allfieldfill
        }
    }
}

enum checkValidationBuyAndSell{
    case title
    case description
    case price
    case country
    case state
    case productType
    case allfieldfill
    
    var errorMessages: String {
        switch self {
        case .title: return "Title can't be empty"
        case .description: return "Description can't be empty"
        case .price: return "Price can't be empty"
        case .country: return "Country can't be empty"
        case .state: return "States can't be empty"
        case .productType: return "Choose Product type"
        case .allfieldfill: return ""
        }
    }
    
    init(title: String, description: String, price: Double, country: String, state: String, productType: String){
        switch true{
        case title.isEmpty: self = .title
        case description.isEmpty: self = .description
        case price == 0.0: self = .price
        case country.isEmpty: self = .country
        case state.isEmpty: self = .state
        case productType == AppConstants.tapToChoose : self = .productType
        default: self = .allfieldfill
        }
    }
}
