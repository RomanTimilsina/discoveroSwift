//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomOfferVC: UIViewController {
    
    let currentView = RoomOfferView()
    
    var roomOffers: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    let filterVC = FilterSelectorVC()
    var isLoading = false
    var firstTime = true
    var country, state: String?
//    var languages: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        debugPrint(self.roomOffers)
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
        currentView.adsTable.register(RoomOfferTableViewCell.self, forCellReuseIdentifier: RoomOfferTableViewCell().identifier)
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
        
        currentView.filterSection.handleFilter = { [weak self] in
            guard let self else { return }
            goToFilterPage()
        }
    }
}

//MARK: Fetch data from firestore
private extension RoomOfferVC {
    func getUsersDataFromDefaults() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            fetchRoomOfferedData(country: userData.country, state: userData.locationDetail.state)
        }
    }
    
    func fetchRoomOfferedData(country: String, state: String) {
        showHUD()
        fireStore.getRoomOffered(isRoomOffer: true, country: country, state: state) { [weak self] roomOffersModel in
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomOfferTableViewCell().identifier, for: indexPath) as! RoomOfferTableViewCell
        cell.selectionStyle = .none
        
        let data = roomOffers[indexPath.row]
        cell.configureData(data: data)
        
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
private extension RoomOfferVC {
    func goToCommentSection() {
        let commentVC = CommentsPageVC()
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func goToFilterPage() {
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
        
        filterVC.onSearchClick = { [weak self] country, state, suburb, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking, minCost, maxCost in
            guard let self else { return }
            debugPrint(property)
            self.roomOffers.removeAll()
            self.currentView.adsTable.reloadData()
            
            fireStore.getRoomOffered(isRoomOffer: true,
                                     country: country,
                                     state: state,
                                     noOfBedroom: Int(noOfBedroom),
                                     noOfBathRoom: Int(noOfBathroom),
                                     noOfParking: Int(noOfParking),
                                     propertyType: property,
                                     language: selectedLanguages,
                                     min: Double(minCost),
                                     max: Double(maxCost)) 
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.roomOffers.append(contentsOf: roomOffersModel)
                    self.currentView.adsTable.reloadData()
                    self.currentView.filterSection.numberOfOffers.text = "\(self.roomOffers.count) offers"
                }
                self.hideHUD()
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
