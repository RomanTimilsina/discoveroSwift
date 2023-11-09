//
//  SelectGenderVC.swift
//  Discovero
//
//  Created by admin on 08/11/2023.
//

import UIKit

class SelectGenderVC: UIViewController {
    
    var currentView = SelectGenderView()
    var selectedGender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        observeViewEvents()
    }
    
    func observeViewEvents() {
        currentView.headerView.onClose = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        currentView.onClickedSave = { [weak self] selectedGender in
            guard let self else { return }
            self.selectedGender = selectedGender.title
            
            switch selectedGender {
            case .Error:
                let alertController = UIAlertController(title: "Error", message: "You haven't selected your gender", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)

                present(alertController, animated: true, completion: nil)
            case .Female, .Male, .Other:
                navigationController?.popViewController(animated: true)

            }

        }
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
}




enum Gender {
    case Male
    case Female
    case Other
    case Error
    
    var title: String {
        switch self {
        case .Male: return "Male"
        case .Female: return "Female"
        case .Other: return "Other"
        case .Error: return ""
        }
    }
}
