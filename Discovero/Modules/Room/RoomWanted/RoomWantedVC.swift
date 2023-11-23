
//  RoomWantedVC.swift
//  Discovero
//
//  Created by admin on 16/10/2023.
//

import UIKit

class RoomWantedVC: UIViewController, UISheetPresentationControllerDelegate{
    
    let currentView = RoomWantedView()
    
    var roomWanted: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    
    let addPicker = DiPickerAddVC()
    let filterVC = FilterSelectorVC()
    
    var onSearchSuccess: ((Int) -> Void)?

    override func viewDidAppear(_ animated: Bool ) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        getUsersDataFromDefaults()
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    func setupTable() {
        currentView.adsTable.register(RoomOfferTableViewCell.self, forCellReuseIdentifier: RoomOfferTableViewCell().identifier)
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
 extension RoomWantedVC {
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
             fetchRoomOfferedData(country: userData.country, state: userData.locationDetail.state)
         }
     }
   
    func fetchRoomOfferedData(country: String, state: String) {
        showHUD()
        fireStore.getRoomOffered(isRoomOffer: false, filterModel: FilterModel(countryName: country, stateName: state)) { [weak self] roomOffersModel in
            guard let self else { return }
            self.roomWanted.append(contentsOf: roomOffersModel)
            self.hideHUD()
            self.currentView.adsTable.reloadData()
            self.currentView.filterSection.numberOfOffers.text = "\(self.roomWanted.count) wanted"
        }
    }
}

//MARK: Table Delegates
extension RoomWantedVC: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row % 5 != 0 || indexPath.row == 0  else {
            debugPrint("Go to Ad")
            return
        }
        
        debugPrint("Room info")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomWanted.count + (roomWanted.count / 4)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row % 5 != 0 || indexPath.row == 0  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomAdCell.identifier, for: indexPath) as! CustomAdCell
            cell.selectionStyle = .none
            cell.configureData("Jasper's market", "Check out our best quality", UIImage(named: "rightAdImage"), UIImage(named: "leftAdImage"))
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomOfferTableViewCell().identifier, for: indexPath) as! RoomOfferTableViewCell
        cell.selectionStyle = .none
        
        let adjustedIndexpath = indexPath.row - (indexPath.row/5)
        let data = roomWanted[adjustedIndexpath]
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
        guard indexPath.row % 5 != 0 || indexPath.row == 0 else {
            return 70
        }
        return 254
    }
}

//MARK: Navigation function
private extension RoomWantedVC {
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
            self.roomWanted.removeAll()
//            self.currentView.adsTable.reloadData()
            self.showHUD()
            
            fireStore.getRoomOffered(isRoomOffer: false, filterModel: filterModel)
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.roomWanted.append(contentsOf: roomOffersModel)
                    self.hideHUD()
                    self.currentView.adsTable.reloadData()
                    self.currentView.filterSection.numberOfOffers.text = "\(self.roomWanted.count) offers"
                }
                self.hideHUD()
                self.currentView.filterSection.filterNumber.text = "\(filterModel.filterCount ?? 0)"
                onSearchSuccess?(self.roomWanted.count)
            }
        }
    }
}

extension RoomWantedVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight - 100 {
            
        }
    }
}
