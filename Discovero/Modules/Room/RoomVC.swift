//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let roomView = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTable()
    }
    
    override func loadView() {
        view = roomView
    }
    
    func setupTable() {
        roomView.adsTable.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell().identifier)
        roomView.adsTable.delegate = self
        roomView.adsTable.dataSource = self
        
    }
}

extension RoomVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell().identifier, for: indexPath) as! RoomTableViewCell
        cell.selectionStyle = .none
        
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
