//
//  JobWantedVC.swift
//  Discovero
//
//  Created by admin on 03/11/2023.
//

import UIKit

class JobWantedVC: UIViewController, UISheetPresentationControllerDelegate{
    
    let currentView = JobWantedView()
    
    var jobWanted: [RoomOffer] = []
    var fireStore = FireStoreDatabaseHelper()
    
    let filterVC = FilterSelectorVC()
    let addPicker = DiPickerAddVC()
    
    var onSearchSuccess: ((Int) -> Void)?
    
    override func viewDidAppear(_ animated: Bool ) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        observeEvents()
        getUsersDataFromDefaults()
    }
    
    override func loadView() {
        super.loadView()
        view = currentView
    }
    
    func setupTable() {
        currentView.adsTable.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell().identifier)
        currentView.adsTable.delegate = self
        currentView.adsTable.dataSource = self
    }
    
    func observeEvents() {
        currentView.filterSection.ontFilterClick = { [weak self] in
            guard let self else { return }
            goToFilterPage()
        }
        
        currentView.onCLickedAdd = { [weak self] in
            guard let self else { return }
            openpicker()
        }
    }
}

//MARK: Fetch data from firestore
extension JobWantedVC {
    func openpicker() {
        addPicker.modalPresentationStyle = .automatic
        if let sheet = addPicker.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [.custom { _ in return 220}]
            sheet.delegate = self
        }
        present(addPicker, animated: true, completion: nil)
    }
    
    func getUsersDataFromDefaults() {
        fetchJobOfferedData(country: CurrentUser.user.data?.country ?? "", state: CurrentUser.user.data?.locationDetail.state ?? "")
    }
    
    func fetchJobOfferedData(country: String, state: String) {
        showHUD()
        fireStore.getRoomOffered(isRoomOffer: false, filterModel: FilterModel(countryName: country, stateName: state)) { [weak self] roomOffersModel in
            guard let self else { return }
            self.jobWanted.append(contentsOf: roomOffersModel)
            self.hideHUD()
            self.currentView.adsTable.reloadData()
            self.currentView.filterSection.numberOfOffers.text = "\(self.jobWanted.count) wanted"
        }
    }
}

//MARK: Table Delegates
extension JobWantedVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomWanted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell().identifier, for: indexPath) as! JobTableViewCell
        cell.selectionStyle = .none
        
        let data = roomWanted[indexPath.row]
        cell.configureData(data: data)
        
        cell.onLikeClicked = { [weak self] in
            guard let self else { return}
            //on like clicked
        }
        
        cell.onCallClicked = { [weak self] in
            guard let self else { return}
            //on process
        }
        
        cell.onMessageClicked = { [weak self] in
            guard let self else { return}
            //on process
        }
        
        cell.onCommentsClicked = { [weak self] in
            guard let self else { return}
            self.goToCommentSection()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 254
    }
}

//MARK: Navigation function
private extension JobWantedVC {
    func goToCommentSection() {
        let commentVC = CommentsPageVC()
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func goToFilterPage() {
        filterVC.filterChoice = .job
        
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
    
        
        filterVC.onSearchClick = { [weak self] filterModel in
            guard let self else { return }
            self.jobWanted.removeAll()
            //            self.currentView.adsTable.reloadData()
            self.showHUD()
            
            fireStore.getRoomOffered(isRoomOffer: false, filterModel: filterModel)
            { [weak self] roomOffersModel in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.jobWanted.append(contentsOf: roomOffersModel)
                    self.hideHUD()
                    self.currentView.adsTable.reloadData()
                    self.currentView.filterSection.numberOfOffers.text = "\(self.jobWanted.count) offers"
                }
                self.hideHUD()
                self.currentView.filterSection.filterNumber.text = "\(filterModel.filterCount ?? 0)"
                onSearchSuccess?(self.jobWanted.count)
            }
        }
    }
}

extension JobWantedVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight - 100 {
            
        }
    }
}
