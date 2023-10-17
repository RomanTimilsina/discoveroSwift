
//  RoomWantedVC.swift
//  Discovero
//
//  Created by admin on 16/10/2023.
//

import UIKit

class RoomWantedVC: UIViewController{
    
    let roomWantedView = RoomWantedView()
    var roomWanted: [RoomOffer] = []
    var items: [RoomOffer] = []
    var numberOLinesForDescription: [Int] = []
    var fireStore = FireStoreDatabaseHelper()
    var isLoading = false
    var firstTime = true
    var loadMore = true
    var timer: Timer?
    var country , state: String?
    var heights = [CGFloat]()
    let filterVC = FilterSelectorVC()
    var countryName, stateName, suburbName, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking: String?
    var languages: [String] = []
    
    override func viewDidAppear(_ animated: Bool ) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()

        getUsersDataFromDefaults()
//        roomWantedView.roomOffer = roomWanted
    }
    
    override func loadView() {
        super.loadView()
        view = roomWantedView
    }
    
    func setupTable() {
        roomWantedView.adsTable.register(RoomOfferTableViewCell.self, forCellReuseIdentifier: RoomOfferTableViewCell().identifier)
        roomWantedView.adsTable.delegate = self
        roomWantedView.adsTable.dataSource = self
    }
    
    func observeEvents() {
        //        roomView.let  = { [weak self] in
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
        
        roomWantedView.filterSection.handleFilter = { [weak self] in
            guard let self else { return }
            filterVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(filterVC, animated: true)
        }
        
        filterVC.handlePop = { [weak self] country, state, suburb, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking, minCost, maxCost in
            guard let self else { return }
            debugPrint(selectedLanguages)
            self.roomWanted = []
            self.roomWanted.removeAll()
            self.roomWantedView.adsTable.reloadData()

            fireStore.getRoomOffered(isRoomOffer: false, country: country,
                                     state: state,
                                     noOfBedroom: Int(noOfBedroom),
                                     noOfBathRoom: Int(noOfBathroom),
                                     noOfParking: Int(noOfParking),
                                     language: selectedLanguages,
                                     min: Double(minCost),
                                     max: Double(maxCost)
            ) { [weak self] roomOffersModel in
                guard let self else { return }
//                self.filterRoomOffers.append(contentsOf: roomOffersModel)
                DispatchQueue.main.async {
                    self.roomWanted.append(contentsOf: roomOffersModel)
                       self.roomWantedView.adsTable.reloadData()
                    }
                self.hideHUD()
                }
        }
    }
    
    
    
    
    
}

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
        
        print(data)
        cell.configureData(data: data)
        cell.handleLike = {
            print("click")
        }
        
        cell.handleCall = {
            //on process
        }
        
        cell.handleMessage = {
            //on process
        }
        
        cell.handleComments = { [ weak self] in
            guard let self else { return }
            self.toGoCommentSection()
        }
        
        return cell
    }
    
    func toGoCommentSection() {
        let vc = OnSelectPageVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //        let data = roomOffers[indexPath.row]
        //        let approximateHeightOfFont = 30
        //        let approximateNoOfLetters = 40
        //        let heightOfEmptyTable = 245
        //        let labelHeight = (((data.description.count)/approximateNoOfLetters) * approximateHeightOfFont) + heightOfEmptyTable
        return 254
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight - 100 && !isLoading  {
//            fetchMoreRoomData()
            
            isLoading = true
        }
    }
}

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
            self.roomWantedView.adsTable.reloadData()
            self.roomWantedView.filterSection.numberOfOffers.text = "\(self.roomWanted.count) wanted"
        }
    }
}
