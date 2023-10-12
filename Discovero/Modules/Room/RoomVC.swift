//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomVC: UIViewController {
    
    let roomView = RoomView()
    var roomOffers: [RoomOffer] = []
    var items: [RoomOffer] = []
    var numberOfLinesForDescriptions: [Int] = []
    var fireStore = FireStoreDatabaseHelper()
    var isLoading = false
    var firstTime = true
    var loadMore = true
    var timer: Timer?
    var country, state: String?
    var heights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTable()
        observeEvents()
        
        getUsersData()
        fetchRoomOfferedData()
        roomView.roomOffer = roomOffers
    }
    
    override func loadView() {
        view = roomView
    }
    
    func setupTable() {
        roomView.adsTable.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell().identifier)
        roomView.adsTable.delegate = self
        roomView.adsTable.dataSource = self
    }
    
    func observeEvents() {
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
        
        roomView.filterSection.handleFilter = { [weak self] in
            guard let self else { return }
            let filterVC = FilterSelectorVC()
            filterVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(filterVC, animated: true)
        }
    }
    

    
    func getUsersData() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            
            fireStore.country = userData.country
            fireStore.state = userData.locationDetail.state
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

    private func fetchRoomOfferedData() {
        showHUD()
        fireStore.getRoomOffered(completion: { [weak self] (rooms: [RoomOffer]) in
            self?.roomOffers.removeAll()
            guard let self = self else { return }
            
            if !isLoading {
                self.roomOffers.append(contentsOf: rooms)
            }
            
            DispatchQueue.main.async {
                self.hideHUD()
                self.roomView.adsTable.reloadData()
            }
            
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)


        })
    }
    
    @objc func updateTime() {
           isLoading = false
        }
    
    private func fetchMoreRoomData() {
        showHUD()
        fireStore.getMoreRooms(completion: { [weak self] (rooms: [RoomOffer], isBoolVal) in
            self?.roomOffers.removeAll()
            guard let self = self else { return }
            self.roomOffers.append(contentsOf: rooms)
            loadMore = isBoolVal
            
            DispatchQueue.main.async {
                self.hideHUD()
                self.roomView.adsTable.reloadData()
            }
        })
    }
}

extension RoomVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell().identifier, for: indexPath) as! RoomTableViewCell
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
        
        cell.handleComments = {
            //on process
        }
        
        return cell
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



