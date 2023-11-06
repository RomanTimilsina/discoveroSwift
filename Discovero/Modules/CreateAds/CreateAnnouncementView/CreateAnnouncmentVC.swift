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
        currentView.announcement.textField.delegate = self
        
        currentView.nextButton.setInvalidState()
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

// MARK: - Textfield delegates
extension CreateAnnouncmentVC: UITextFieldDelegate {
    // MARK: Activate button if textfield has name
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            if updatedText.isEmpty {
                currentView.nextButton.setInvalidState()
            } else {
                currentView.nextButton.setValidState()
            }
        }
        return true
    }
}

