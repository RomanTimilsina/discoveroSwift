//
//  ViewController.swift
//  Discovero
//
//  Created by Sujal Shrestha on 03/09/2023.
//

import UIKit

class OnBoardingPageVC: UIViewController {
    
    let currentView = OnBoardingPageView()
    let onBoarding = OnBoardingPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBoarding.backgroundColor = Color.appBlack
        setupCollectionView()
    }
    
    func setupCollectionView() {
        onBoarding.onBoardingCollection.register(OnBoardingPageViewCell.self, forCellWithReuseIdentifier: "cell")
        onBoarding.onBoardingCollection.delegate = self
        onBoarding.onBoardingCollection.dataSource = self
    }
    
    override func  loadView() {
        view = onBoarding
    }
}

extension OnBoardingPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = OnBoardingCollectionManager().getData()[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingPageViewCell
        cell.configureCellData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:  view.frame.height*0.728)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

