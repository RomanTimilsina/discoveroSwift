//
//  JobOfferVC.swift
//  Discovero
//
//  Created by admin on 03/11/2023.
//

import UIKit

class JobOfferVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = JobOfferView()
    
    var jobOffers: [RoomOffer] = []
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
        //MARK: Pull to refresh need to be done
        //        roomView.handleRoomRefresh = { [weak self] in
        //
        //            self?.fireStore.getRoomOffered { [weak self] rooms in
        //                self?.roomOffers.removeAll()
        //                guard let self = self else { return }
        //                self.roomOffers.append(contentsOf: rooms)
        //
        //                DispatchQueue.main.async {
        //                    self.roomView.adsTable.reloadData()
        //                }
        //                roomView.refreshControl.endRefreshing()
        //            }
        //        }
        
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
            sheet.detents = [.medium(), .custom { _ in return 200}]
            sheet.delegate = self
        }
        present(addPicker, animated: true, completion: nil)
    }
    
    func getUsersDataFromDefaults() {
        let users = CurrentUser.user.data
        fetchJobOfferedData(filterModel: FilterModel(countryName: users?.country, stateName: users?.locationDetail.state))

    }
    
    func fetchJobOfferedData(filterModel: FilterModel) {
        showHUD()
        self.jobOffers.removeAll()
        fireStore.getRoomOffered(isRoomOffer: true, filterModel: filterModel) { [weak self] roomOffersModel in
            guard let self else { return }
            self.jobOffers.append(contentsOf: roomOffersModel)
            self.hideHUD()
            self.currentView.adsTable.reloadData()
            self.currentView.filterSection.numberOfOffers.text = "\(self.jobOffers.count) offers"
        }
    }
}

//MARK: Table Delegates
extension JobOfferVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell().identifier, for: indexPath) as! JobTableViewCell
        cell.selectionStyle = .none
        
        let data = roomOffers[indexPath.row]
        cell.configureData(data: data)
 
        cell.onLikeClicked = { [weak self] in
            guard let self else { return}
            //on like clicked
        }
        
        cell.onCallClicked = { [weak self] in
            guard let self else { return}
            //on process
        }
        
        cell.onMessageClicked = { [weak self] in
            guard let self else { return}
            //on process
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
    func goToCommentSection() {
        let commentVC = CommentsPageVC()
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func goToFilterPage() {
        filterVC.filterChoice = .job
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
        
        filterVC.onSearchClick = { [weak self] filterModel in
            guard let self else { return }
            self.jobOffers.removeAll()
//            self.currentView.adsTable.reloadData()
            self.showHUD()
            
            fireStore.getRoomOffered(isRoomOffer: true, filterModel: filterModel)
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.jobOffers.append(contentsOf: roomOffersModel)
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

