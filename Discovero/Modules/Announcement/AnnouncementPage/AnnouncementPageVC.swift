//
//  AnnouncementPageVC.swift
//  Discovero
//
//  Created by admin on 23/11/2023.
//

import UIKit

class AnnouncementPageVC: UIViewController{
    
    let announcementPageView = AnnouncementPageView()
    let announcementCell = AnnouncementCell()
    var newdata :((Int)-> Void)?
    var newlike :((Int)-> Void)?
    var newcomments: ((Int)-> Void)?
    var likes : Int?
    var comment : Int?
    var userName: String?
    var postImg: UIImage?
    var profilepic : UIImage?
    var viewscount: Int?
    var passedValue: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .black
        observeTapAction()
        announcementPageView.viewCount.text = "100"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        announcementPageView.userId.text = userName
        announcementPageView.profilePic.image = profilepic
        //        announcementPageView.textView = postImg
        announcementPageView.viewCount.text = "\(viewscount)"
        announcementPageView.likes.text = "\(likes)"
        announcementPageView.comments.text = "\(comment)"
    }
    
    override func loadView() {
        super.loadView()
        view = announcementPageView
    }
    
    func observeTapAction() {
        announcementPageView.viewButtonTap = { [weak self] in
            guard let self = self else { return }
            self.newdata?((viewscount ?? 100) + 1)
            self.newlike?((likes ?? 0) + 1)
            self.newcomments?((comment ?? 0) + 1)
        }
    }
}



