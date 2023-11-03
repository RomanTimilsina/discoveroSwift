//
//  CreateAnnouncmentVC.swift
//  Discovero
//
//  Created by admin on 02/11/2023.
//

import UIKit

class CreateAnnouncmentVC: UIViewController {
    
    var currentView = CreateAnnouncmentView()
    
    let postPreview = PostPreviewVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.header.onClose = { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
        }
        
        currentView.onClickedNext = { [weak self] in
            guard let self else { return }
            gotoPostPreview()
        }
    }
    
    func gotoPostPreview() {
        postPreview.currentView.postView.announcementlabel.text = currentView.announcement.textField.text
        postPreview.currentView.postView.middleAdStack.removeFromSuperview()
        postPreview.currentView.postView.eyeImage.removeFromSuperview()
        
        navigationController?.pushViewController(postPreview, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
}
