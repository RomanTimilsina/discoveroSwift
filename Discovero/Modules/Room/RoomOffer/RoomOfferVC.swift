//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomOfferVC: UIViewController, UISheetPresentationControllerDelegate {
    
    let currentView = RoomOfferView()
    
    var roomOffers: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    
    let addPicker = DiPickerAddVC()
    let filterVC = FilterSelectorVC()

    var onSearchSuccess: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        getUsersDataFromDefaults()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        view = currentView
    }
    
    func setupTable() {
        currentView.adsTable.register(RoomOfferTableViewCell.self, forCellReuseIdentifier: RoomOfferTableViewCell().identifier)
        currentView.adsTable.register(CustomAdCell.self, forCellReuseIdentifier: CustomAdCell.identifier)

        currentView.adsTable.delegate = self
        currentView.adsTable.dataSource = self
    }
    
    func observeEvents() {
        //MARK: Pull to refresh need to be done
        //                currentView.handleRoomRefresh = { [weak self] in
        //
        //                    self?.fireStore.getRoomOffered { [weak self] rooms in
        //                        self?.roomOffers.removeAll()
        //                        guard let self = self else { return }
        //                        self.roomOffers.append(contentsOf: rooms)
        //
        //                        DispatchQueue.main.async {
        //                            self.roomView.adsTable.reloadData()
        //                        }
        //                        roomView.refreshControl.endRefreshing()
        //                    }
        //                }
        
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
private extension RoomOfferVC {
    
    func openAddPicker(){
        addPicker.modalPresentationStyle = .automatic
        if let sheet = addPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.custom { _ in return 220}]
            sheet.delegate = self
        }
        present(addPicker, animated: true, completion: nil)
    }
    
    func getUsersDataFromDefaults() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            fetchRoomOfferedData(filterModel: FilterModel(countryName: userData.country, stateName: userData.locationDetail.state))
        }
    }
    
    func fetchRoomOfferedData(filterModel: FilterModel) {
        showHUD()
        self.roomOffers.removeAll()
        fireStore.getRoomOffered(isRoomOffer: true, filterModel: filterModel) { [weak self] roomOffersModel in
            guard let self else { return }
            self.roomOffers.append(contentsOf: roomOffersModel)
            self.hideHUD()
            self.currentView.adsTable.reloadData()
            self.currentView.filterSection.numberOfOffers.text = "\(self.roomOffers.count) offers"
        }
    }
}

//MARK: Table Delegates
extension RoomOfferVC: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row % 4 != 0 || indexPath.row == 0  else {
            debugPrint("Go to Ad")
            return
        }
        
        debugPrint("Room info")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOffers.count + (roomOffers.count / 4)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row % 4 != 0 || indexPath.row == 0  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomAdCell.identifier, for: indexPath) as! CustomAdCell
            cell.selectionStyle = .none
            cell.configureData("Jasper's market", "Check out our best quality", UIImage(named: "rightAdImage"), UIImage(named: "leftAdImage"))
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomOfferTableViewCell().identifier, for: indexPath) as! RoomOfferTableViewCell
        cell.selectionStyle = .none
        
        let adjustedIndexpath = indexPath.row - (indexPath.row/4)
        let data = roomOffers[adjustedIndexpath]
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
            goToCommentSection()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row % 4 != 0 || indexPath.row == 0 else {
            return 70
        }
        return 254
    }
}

//MARK: Navigation function
private extension RoomOfferVC {
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
        filterVC.filterChoice = .room
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
        
        filterVC.onSearchClick = { [weak self] filterModel in
            guard let self else { return }
            self.roomOffers.removeAll()
            self.showHUD()
            
            fireStore.getRoomOffered(isRoomOffer: true, filterModel: filterModel)
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.roomOffers.append(contentsOf: roomOffersModel)
                    self.hideHUD()
                    self.currentView.adsTable.reloadData()
                    self.currentView.filterSection.numberOfOffers.text = "\(self.roomOffers.count) offers"
                }
                self.hideHUD()
                self.currentView.filterSection.filterNumber.text = "\(filterModel.filterCount ?? 0)"
                onSearchSuccess?(self.roomOffers.count)
            }
        }
    }
}

//MARK: Pagination need to be done
extension RoomOfferVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight - 100 {
        }
    }
}
