
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
        
        getUsersData()
        fetchRoomOfferedData()
        roomWantedView.roomOffer = roomWanted
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
        
        filterVC.handlePop = { [weak self] country, state, suburb, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking, min, max in
            guard let self else { return }

            countryName = country
            stateName = state
            suburbName = suburb
            self.property = property
            self.languages = selectedLanguages
            self.noOfBedroom = noOfBedroom
            self.noOfBathroom = noOfBathroom
            self.noOfParking = noOfParking
            print(countryName , stateName , suburbName , self.property , self.languages ?? "", self.noOfBedroom , self.noOfBathroom ?? "", self.noOfParking ?? "")
        }
    }
    
    
    func getUsersData() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            
            fireStore.country = userData.country
            fireStore.state = userData.locationDetail.state
        }
    }
    
    private func fetchRoomOfferedData() {
        showHUD()
        fireStore.getRoomOffered(completion: { [weak self] (rooms: [RoomOffer]) in
            self?.roomWanted.removeAll()
            guard let self = self else { return }
            
            if !isLoading {
                self.roomWanted.append(contentsOf: rooms)
            }
            
            DispatchQueue.main.async {
                self.hideHUD()
                self.roomWantedView.adsTable.reloadData()
            }
            
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        })
    }
    
    @objc func updateTime() {
        isLoading = false
    }
    
    private func fetchMoreRoomData() {
        showHUD()
        fireStore.getRoomOffered(completion: { [weak self] (rooms: [RoomOffer]) in
            self?.roomWanted.removeAll()
            guard let self = self else { return }
            self.roomWanted.append(contentsOf: rooms)
//            loadMore = isBoolVal
            
            DispatchQueue.main.async {
                self.hideHUD()
                self.roomWantedView.adsTable.reloadData()
            }
        })
    }
}

extension RoomWantedVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomOfferTableViewCell().identifier, for: indexPath) as! RoomOfferTableViewCell
        cell.selectionStyle = .none
        let data = roomOffers[indexPath.row]
        
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
            fetchMoreRoomData()
            
            isLoading = true
        }
    }
}
