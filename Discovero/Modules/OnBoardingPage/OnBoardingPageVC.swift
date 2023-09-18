//
//  ViewController.swift
//  Discovero
//
//  Created by Sujal Shrestha on 03/09/2023.
//

import UIKit

class OnBoardingPageVC: UIViewController {
    
    let currentView = OnBoardingPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentView.backgroundColor = Color.appBlack
        setupCollectionView()
        observeViewEvents()
    }
    
    func setupCollectionView() {
        currentView.onboardingCollection.register(OnBoardingPageViewCell.self, forCellWithReuseIdentifier: OnBoardingPageViewCell.identifier)
        currentView.onboardingCollection.delegate = self
        currentView.onboardingCollection.dataSource = self
    }
    
    override func  loadView() {
        view = currentView
    }
    
    func observeViewEvents() {
        currentView.handleLoginClicked = {[weak self] in
            guard let self = self else {return}
            gotoLogin(isFromLogin: true)
        }
        
        currentView.handleRegisterClicked = {[weak self] in
            guard let self = self else {return}
            gotoLogin(isFromLogin: false)
        }
    }
    
    private func gotoLogin(isFromLogin: Bool) {
        let login = LoginVC()
        login.isFromLogin = isFromLogin
        navigationController?.pushViewController(login, animated: true)
    }
}

extension OnBoardingPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = OnBoardingCollectionManager().getData()[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingPageViewCell.identifier, for: indexPath) as! OnBoardingPageViewCell
        cell.configureCellData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:  view.frame.height * 0.728)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: currentView.onboardingCollection.contentOffset, size: currentView.onboardingCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = currentView.onboardingCollection.indexPathForItem(at: visiblePoint){
            currentView.indicator.currentPage = visibleIndexPath.row
        }
    }
}
