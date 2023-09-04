//
//  DIPageViewController.swift
//  Discovero
//
//  Created by Mac on 04/09/2023.
//
import UIKit

class DIPageController: UIPageControl {
    
    var currentPageImage: UIImage?
    
    var otherPagesImage: UIImage?
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultConfigurationForiOS14AndAbove()
    }
    
    private func defaultConfigurationForiOS14AndAbove() {
        for index in 0..<numberOfPages {
            let image = index == currentPage ? currentPageImage : otherPagesImage
            setIndicatorImage(image, forPage: index)
        }
        
        pageIndicatorTintColor = #colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)
        currentPageIndicatorTintColor = Color.primary
    }
    
    private func updateDots() {
        defaultConfigurationForiOS14AndAbove()
    }
    
    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView
            
            return view
        }
    }
}






