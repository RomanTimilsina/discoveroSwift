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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTable()
        fetchRoomOfferedData()
    }
    
    override func loadView() {
        view = roomView
    }
    
    func setupTable() {
        roomView.adsTable.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell().identifier)
        roomView.adsTable.delegate = self
        roomView.adsTable.dataSource = self
    }
    
    private func fetchRoomOfferedData() {
        FireStoreDatabaseHelper().getRoomOffered { [weak self] documents in
            self?.roomOffers.removeAll()
            guard let self = self else { return }

            for document in documents {

                let data = document.data()
                let id = data["id"] as? String
                let title = data["title"] as? String
                let description = data["description"] as? String
                let price = data["price"] as? Double
                let bedrooms = data["bedrooms"] as? Int
                let bathrooms = data["bathrooms"] as? Int
                let parkings = data["parkings"] as? Int
                let viewCount = data["viewCount"] as? Int
                let commentCount = data["commentCount"] as? Int
                let isAnonymous = data["isAnonymous"] as? Bool
                let userInfoData = data["userInfo"] as? [String: Any]
                let locationData = data["location"] as? [String: String]
                let comments = data["comments"] as? [String]
                let favorites = data["favorites"] as? [String]
                
                let userInfoName = userInfoData?["name"] as? String
                let userInfoPhoneNo = userInfoData?["phoneNo"] as? String
                let userInfoLanguagesSpeaks = userInfoData?["languagesSpeaks"] as? [String]
                let userInfoUid = userInfoData?["uid"] as? [String]
                let locationBuildingNo = locationData?["buildingNo"]
                let locationCountry = locationData?["country"]
                let locationState = locationData?["state"]
                let locationStreetName = locationData?["streetName"]
                let locationStreetNo = locationData?["streetNo"]
                let locationSuburb = locationData?["suburb"]
                
                
                let userInfo = UserInfo(
                    name: userInfoName ?? "",
                    phoneNo: userInfoPhoneNo ?? "",
                    languagesSpeaks: userInfoLanguagesSpeaks ?? [],
                    uid: userInfoUid ?? []
                )
                
                let location = Location(
                    buildingNo: locationBuildingNo ?? "",
                    country: locationCountry ?? "",
                    state: locationState ?? "",
                    streetName: locationStreetName ?? "",
                    streetNo: locationStreetNo ?? "",
                    suburb: locationSuburb ?? ""
                )
                
                let roomOffer = RoomOffer(
                    id: id ?? "",
                    title: title ?? "",
                    description: description ?? "",
                    price: price ?? 0,
                    bedrooms: bedrooms ?? 0,
                    bathrooms: bathrooms ?? 0,
                    parkings: parkings ?? 0,
                    viewCount: viewCount ?? 0,
                    commentCount: commentCount ?? 0,
                    isAnonymous: isAnonymous ?? false,
                    userInfo: userInfo,
                    location: location,
                    comments: comments ?? [],
                    favorites: favorites ?? []
                )
                self.roomOffers.append(roomOffer)
                print(roomOffers)
            }
            DispatchQueue.main.async {
                        self.roomView.adsTable.reloadData()
                    }
        }
        // Reload the table view to display the fetched data
        
    }
}


extension RoomVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roomOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell().identifier, for: indexPath) as! RoomTableViewCell
        cell.selectionStyle = .none
        print(roomOffers)
       let data = roomOffers[indexPath.row]
        
        print(data)
        cell.configureData(data: data)
        cell.handleLike = {
            print("click")
        }
        
        cell.handleCall = {
            // Handle the "call" action for this cell
            // You can initiate a call or perform any other task here
        }
        
        cell.handleMessage = {
            // Handle the "message" action for this cell
            // You can open a chat screen or perform any other task here
        }
        
        cell.handleComments = {
            // Handle the "comments" action for this cell
            // You can open a comments view or perform any other task here
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
}
