
//  RoomWantedVC.swift
//  Discovero
//
//  Created by admin on 16/10/2023.
//

import UIKit

class RoomWantedVC: UIViewController{
    
    let currentView = RoomWantedView()
    
    var roomWanted: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    let filterVC = FilterSelectorVC()
    var isLoading = false
    var firstTime = true
    var country , state: String?
    
    
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
        goToFilterPage()
    }
}

//MARK: Fetch data from firestore
 extension RoomWantedVC {
    func getUsersDataFromDefaults() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            fetchRoomOfferedData(country: userData.country, state: userData.locationDetail.state)
        }
    }
   
    func fetchRoomOfferedData(country: String, state: String) {
        showHUD()
        fireStore.getRoomOffered(isRoomOffer: false, country: country, state: state) { [weak self] roomOffersModel in
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomWanted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomOfferTableViewCell().identifier, for: indexPath) as! RoomOfferTableViewCell
        cell.selectionStyle = .none
        let data = roomWanted[indexPath.row]
        
        if firstTime {
            cell.gapView.isHidden = true
            cell.gapView.constraintHeight(constant: 0)
            firstTime = false
        }
        debugPrint(data)
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
private extension RoomWantedVC {
    func goToCommentSection() {
        let commentVC = CommentsPageVC()
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func goToFilterPage() {
        currentView.filterSection.handleFilter = { [weak self] in
            guard let self else { return }
            filterVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(filterVC, animated: true)
        }
        
        filterVC.onSearchClick = { [weak self] country, state, suburb, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking, minCost, maxCost in
            guard let self else { return }
            debugPrint(selectedLanguages)
            self.roomWanted = []
            self.roomWanted.removeAll()
            self.currentView.adsTable.reloadData()

            fireStore.getRoomOffered(isRoomOffer: false, 
                                     country: country,
                                     state: state,
                                     noOfBedroom: Int(noOfBedroom),
                                     noOfBathRoom: Int(noOfBathroom),
                                     noOfParking: Int(noOfParking),
                                     language: selectedLanguages,
                                     min: Double(minCost),
                                     max: Double(maxCost))
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.roomWanted.append(contentsOf: roomOffersModel)
                       self.currentView.adsTable.reloadData()
                    }
                self.hideHUD()
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
