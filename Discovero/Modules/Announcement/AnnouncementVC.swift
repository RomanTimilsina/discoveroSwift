//
//  AnnouncementVC.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementVC: UIViewController{
    
    let currentView = AnnouncementView()
    
    var announcementModel: [AnnouncementModel] = []
    var fireStore = FireStoreDatabaseHelper()
    
    var newlikes:((Int)-> Void)?
    var newcomments: ((Int)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupCell()
    }
    
    func setupCell() {
        currentView.pageView.register(AnnouncementCell.self, forCellWithReuseIdentifier: AnnouncementCell.cellId)
        currentView.pageView.delegate = self
        currentView.pageView.dataSource = self
    }
    
    override func loadView() {
        view = currentView
    }
}

extension AnnouncementVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnouncementCell.cellId, for: indexPath) as! AnnouncementCell
        
        var data = announcementModel[indexPath.item]
        cell.configureData(data: data)
        
        cell.handleTapPost = {[weak self] in
            guard let self = self else{return}
            print("helo \(indexPath.row)")
            let announcementPageVC = AnnouncementPageVC()
            announcementPageVC.hidesBottomBarWhenPushed = true
            //            announcementPageVC.userName = data.userInfo.name
            ////            announcementPageVC.postImg = data.posts
//            announcementPageVC.profilepic = "\(namePrefix(name: data.userInfo.name))"
            //            announcementPageVC.viewscount = Int(data.views)
            //            announcementPageVC.likes = Int(data.likes)
            //            announcementPageVC.comment = Int(data.comments)
            navigationController?.pushViewController(announcementPageVC, animated: true)
            
            announcementPageVC.newdata = {[weak self] newValue  in
                guard let self = self else {return}
                data.viewCount = newValue
                cell.viewCount.text = "\(newValue)"
            }
            
            announcementPageVC.newlike = {[weak self] newlikes  in
                guard let self = self else {return}
                //                data.likes = "\(newlikes)"
                cell.likeLabel.text = "\(newlikes)"
            }
            
            announcementPageVC.newcomments = {[weak self] newcomments  in
                guard let self = self else {return}
                data.commentCount = newcomments
                cell.commentCount.text = "\(newcomments)"
            }
        }
        
        cell.handleLikeTap = {[weak self, weak cell] in
            guard let self = self, let cell = cell else { return }
            if let currentLikes = Int(cell.likeLabel.text ?? "0") {
                let newLikes = currentLikes + 1
                //                data.likes = "\(newLikes)"
                cell.likeLabel.text = "\(newLikes)"
            }
        }
        
        cell.handleCommentTap = {[weak self] in
            
            guard let self = self else {return}
            if let currentcomments = Int(cell.commentCount.text ?? "0"){
                let newcomments = currentcomments + 1
                data.commentCount = newcomments
                cell.commentCount.text = "\(newcomments)"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 350 , height: 254)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func getUsersDataFromDefaults() {
        fireStore.getUserDataFromDefaults { [weak self] userData in
            guard let self, let userData else { return }
            
            fetchAnnouncementData()
        }
    }
    
    func fetchAnnouncementData() {
        showHUD()
        self.announcementModel.removeAll()
        fireStore.getAnnouncementData() { [weak self] announcementModel in
            guard let self = self else { return }
//            self.announcementModel.append(contentsOf: announcementModel)
            self.hideHUD()
            self.currentView.pageView.reloadData()
//            self.currentView.filterSection.numberOfOffers.text = "\(self.announcementModel.count) offers"
        }
    }
}

// MARK: Formatting data
extension AnnouncementVC {
    func formatDate(from timestamp: Double) -> String {
        let currentDate = Date()
        let date = Date(timeIntervalSince1970: timestamp / 1000) // Convert milliseconds to seconds
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .weekOfYear, .day], from: date, to: currentDate)
        
        if let years = components.year, years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if let weeks = components.weekOfYear, weeks > 0 {
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if let days = components.day, days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss" // Customize the time format as needed
            return dateFormatter.string(from: date)
        }
    }
    
    func namePrefix(name: String) -> String {
        let words = name.split(separator: " ")
        var initials = ""
        for word in words {
            initials += word.prefix(1)
        }
        return initials
    }
}

