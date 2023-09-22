//
//  DICreateAdVC.swift
//  Discovero
//
//  Created by Mac on 07/09/2023.
//

import UIKit

class RoomVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let room = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        room.backgroundColor = Color.appBlack
        room.table.backgroundColor = Color.appBlack
        setupTable()
    }
    
    override func loadView() {
        view = room
    }
    
    func setupTable() {
        room.table.register(RoomTableViewCell.self, forCellReuseIdentifier: "cell")
        room.table.delegate = self
        room.table.dataSource = self
    }
}

extension RoomVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoomTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
