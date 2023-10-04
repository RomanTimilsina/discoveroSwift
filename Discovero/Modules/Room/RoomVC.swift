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
    
//    let pageSize = 5
//    var currentPage = 1
//    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTable()
        fetchRoomOfferedData()
        observeEvents()
//        
//        loadMoreData()
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
//            FireStoreDatabaseHelper().getRoomOffered { [weak self] rooms in
//                self?.roomOffers.removeAll()
//                guard let self = self else { return }
//                self.roomOffers.append(contentsOf: rooms)
//                DispatchQueue.main.async {
//                            self.roomView.adsTable.reloadData()
//                        }
//                roomView.refreshControl.endRefreshing()
//
//                let data = roomOffers[0]
//                let fontToUse = UIFont.systemFont(ofSize: 16) // You can use the desired font
//                let maxWidth = UIScreen.main.bounds.width - 12
//                print(numberOfLinesThatFit(text: data.description, font: fontToUse, maxWidth: maxWidth) * 25)
//            }
//        }
    }
    
//    func loadMoreData() {
//            if isLoading {
//                return
//            }
//            
//            isLoading = true
//            
//            // Simulate an API call or database query
//            DispatchQueue.global().async {
//                // Simulate a delay
//                sleep(2)
//                
//                // Generate new items
//                for rooms in self.roomOffers {
//                    for _ in self.currentPage...self.pageSize {
//                        self.items.append(rooms)
//                    }
//                }
//                
//                
//            }
//        }
    
    
    
    func numberOfLinesThatFit(text: String, font: UIFont, maxWidth: CGFloat) -> Int {
        // Create a label with the same font and set the maximum width
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame.size = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)

        // Set the text to the label and calculate the size needed
        label.text = text
        let textSize = label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        // Calculate the number of lines based on text size and font height
        let lineHeight = ceil(font.lineHeight)
        let numberOfLines = Int(ceil(textSize.height / lineHeight))

        return numberOfLines
    }//
//    // Usage example:
//    let text = "This is some text that you want to check if it fits on the screen."
//    let font = UIFont.systemFont(ofSize: 16) // Change to your desired font
//    let fitsOnScreen = doesTextFitOnScreen(text: text, font: font)
//
//    if fitsOnScreen {
//        print("The text fits on the screen.")
//    } else {
//        print("The text does not fit on the screen.")
//    }

    
    private func fetchRoomOfferedData() {
        showHUD()
        FireStoreDatabaseHelper().getRoomOffered { [weak self] rooms in
            self?.roomOffers.removeAll()
            guard let self = self else { return }

            self.roomOffers.append(contentsOf: rooms)
            DispatchQueue.main.async {
                self.hideHUD()
                        self.roomView.adsTable.reloadData()
                    }
        }
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
        let data = roomOffers[indexPath.row]
        let labelHeight = (((data.description.count)/80) * 30) + 245
        return CGFloat(labelHeight)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let offsetY = scrollView.contentOffset.y
//            let contentHeight = scrollView.contentSize.height
//            let screenHeight = scrollView.frame.size.height
//            
//            if offsetY > contentHeight - screenHeight - 100 && !isLoading {
//                loadMoreData()
//            }
//        }
}



