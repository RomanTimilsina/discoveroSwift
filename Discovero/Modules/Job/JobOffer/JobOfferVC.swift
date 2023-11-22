//
//  JobOfferVC.swift
//  Discovero
//
//  Created by admin on 03/11/2023.
//

import UIKit

class JobOfferVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = JobOfferView()
    
    var jobOffers: [JobOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    
    let addPicker = DiPickerAddVC()
    let filterVC = FilterSelectorVC()
    
    var onSearchSuccess: ((Int) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        getUsersDataFromDefaults()
//        fireStore.getJobsOffered(isJobOffer: true, filterModel: FilterModel()) { model in
//            debugPrint(model)
//        }
    }
    
    override func loadView() {
        view = currentView
    }
    
    func setupTable() {
        currentView.adsTable.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell().identifier)
        currentView.adsTable.delegate = self
        currentView.adsTable.dataSource = self
    }
    
    func observeEvents() {
        currentView.filterSection.ontFilterClick = { [weak self] in
            guard let self else { return }
            goToFilterPage()
        }
        
        currentView.onCLickedAdd = { [weak self] in
            guard let self else { return }
            openAddPicker()
        }
    }
}

//MARK: Fetch data from firestore
private extension JobOfferVC {
    
    func openAddPicker(){
        addPicker.modalPresentationStyle = .automatic
        if let sheet = addPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.medium(), .custom { _ in return 220}]
            sheet.delegate = self
        }
        present(addPicker, animated: true, completion: nil)
    }
    
    func getUsersDataFromDefaults() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            
            fetchJobOfferedData(filterModel: FilterModel(countryName: userData.country, stateName: userData.locationDetail.state))
        }
    }
    
    func fetchJobOfferedData(filterModel: FilterModel) {
        showHUD()
        self.jobOffers.removeAll()
        fireStore.getJobsOffered(isJobOffer: true, filterModel: filterModel) { [weak self] jobOffersModel in
            guard let self else { return }
            self.jobOffers.append(contentsOf: jobOffersModel)
            self.hideHUD()
            self.currentView.adsTable.reloadData()
            self.currentView.filterSection.numberOfOffers.text = "\(self.jobOffers.count) offers"
        }
    }
}

//MARK: Table Delegates
extension JobOfferVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell().identifier, for: indexPath) as! JobTableViewCell
        cell.selectionStyle = .none
        
        let data = jobOffers[indexPath.row]
        cell.configureData(data: data)
        
        cell.onLikeClicked = { [weak self] in
            guard let self else { return}
            //on like clicked
        }
        
        cell.onCallClicked = { [weak self] in
            guard let self else { return}
            goToPhoneApp()
        }
        
        cell.onMessageClicked = { [weak self] in
            guard let self else { return}
            goToMessageApp()
        }
        
        cell.onCommentsClicked = { [weak self] in
            guard let self else { return}
            self.goToCommentSection()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 254
    }
}

//MARK: Navigation function
private extension JobOfferVC {
    func goToPhoneApp() {
        let phoneNumber = "123456789"

        if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    func goToMessageApp() {
        let phoneNumber = "123456789"

        if let smsURL = URL(string: "sms:\(phoneNumber)"), UIApplication.shared.canOpenURL(smsURL) {
            UIApplication.shared.open(smsURL, options: [:], completionHandler: nil)
        }
    }
    
    func goToCommentSection() {
        let commentVC = CommentsPageVC()
        commentVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func goToFilterPage() {
        filterVC.filterChoice = .job
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
        
        filterVC.onSearchClick = { [weak self] filterModel in
            guard let self else { return }
            self.jobOffers.removeAll()
            self.showHUD()
            
            fireStore.getJobsOffered(isJobOffer: true, filterModel: FilterModel() )
            { [weak self] jobOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.jobOffers.append(contentsOf: jobOffersModel)
                    self.hideHUD()
                    self.currentView.adsTable.reloadData()
                    self.currentView.filterSection.numberOfOffers.text = "\(self.jobOffers.count) offers"
                }
                self.hideHUD()
                self.currentView.filterSection.filterNumber.text = "\(filterModel.filterCount ?? 0)"
                onSearchSuccess?(self.jobOffers.count)
            }
        }
    }
}

//MARK: Pagination need to be done
extension JobOfferVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight - 100 {
        }
    }
}

