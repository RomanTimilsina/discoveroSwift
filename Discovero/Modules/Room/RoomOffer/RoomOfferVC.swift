//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomOfferVC: UIViewController {
    
    let roomOfferView = RoomOfferView()
    var roomOffers: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    var country, state: String?
    let filterVC = FilterSelectorVC()
    var languages: [String] = []
    
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
        view = roomOfferView
    }
    
    func setupTable() {
        roomOfferView.adsTable.register(RoomOfferTableViewCell.self, forCellReuseIdentifier: RoomOfferTableViewCell().identifier)
        roomOfferView.adsTable.delegate = self
        roomOfferView.adsTable.dataSource = self
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
        
        roomOfferView.filterSection.handleFilter = { [weak self] in
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
            self.roomOfferView.adsTable.reloadData()
            self.roomOfferView.filterSection.numberOfOffers.text = "\(self.roomOffers.count) offers"
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
        
        cell.handleLike = { [weak self] in
            guard let self else { return}
            //on like clicked
        }
        
        cell.handleCall = { [weak self] in
            guard let self else { return}
            //on process
        }
        
        cell.handleMessage = { [weak self] in
            guard let self else { return}
            //on process
        }
        
        cell.handleComments = { [weak self] in
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
        let vc = OnSelectPageVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToFilterPage() {
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
        
        filterVC.handlePop = { [weak self] country, state, suburb, property, selectedLanguages, noOfBedroom, noOfBathroom, noOfParking, minCost, maxCost in
            guard let self else { return }
            debugPrint(property)
            //            self.roomOffers = []
            self.roomOffers.removeAll()
            self.roomOfferView.adsTable.reloadData()
            
            fireStore.getRoomOffered(isRoomOffer: true,
                                     country: country,
                                     state: state,
                                     noOfBedroom: Int(noOfBedroom),
                                     noOfBathRoom: Int(noOfBathroom),
                                     noOfParking: Int(noOfParking),
                                     propertyType: property,
                                     language: selectedLanguages,
                                     min: Double(minCost),
                                     max: Double(maxCost)) { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.roomOffers.append(contentsOf: roomOffersModel)
                    self.roomOfferView.adsTable.reloadData()
                    self.roomOfferView.filterSection.numberOfOffers.text = "\(self.roomOffers.count) offers"
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
    
    //    func loadMoreData() {
    //        if isLoading {
    //            return
    //        }
    //
    //        isLoading = true
    //
    //        // Simulate an API call or database query
    //        DispatchQueue.global().async {
    //            // Simulate a delay
    //            sleep(2)
    //
    //            // Generate new items for the next page
    //            let startIndex = self.currentPage * self.pageSize
    //            let endIndex = startIndex + self.pageSize
    //
    //            // Ensure that endIndex does not exceed the total number of room offers
    //            let count = self.roomOffers.count
    //            let nextPageItems = Array(self.roomOffers[startIndex..<min(endIndex, count)])
    //
    //            self.items.append(contentsOf: nextPageItems)
    //
    //            // Update the UI on the main thread
    //            DispatchQueue.main.async {
    //                self.roomView.adsTable.reloadData()
    //                self.isLoading = false
    //                self.currentPage += 1
    //            }
    //        }
    //    }
    
    //    func numberOfLinesThatFit(text: String, font: UIFont, maxWidth: CGFloat) -> Int {
    //        // Create a label with the same font and set the maximum width
    //        let label = UILabel()
    //        label.font = font
    //        label.numberOfLines = 0
    //        label.lineBreakMode = .byWordWrapping
    //        label.frame.size = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
    //
    //        // Set the text to the label and calculate the size needed
    //        label.text = text
    //        let textSize = label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    //
    //        // Calculate the number of lines based on text size and font height
    //        let lineHeight = ceil(font.lineHeight)
    //        let numberOfLines = Int(ceil(textSize.height / lineHeight))
    //
    //        return numberOfLines
    //    }
    
    
    //    private func fetchMoreRoomData() {
    //        showHUD()
    //        fireStore.getMoreRooms(completion: { [weak self] (rooms: [RoomOffer], isBoolVal) in
    //            self?.roomOffers.removeAll()
    //            guard let self = self else { return }
    //            self.roomOffers.append(contentsOf: rooms)
    //            loadMore = isBoolVal
    //
    //            DispatchQueue.main.async {
    //                self.hideHUD()
    //                self.roomView.adsTable.reloadData()
    //            }
    //        })
    //    }
}
