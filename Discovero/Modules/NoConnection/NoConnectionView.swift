//
//  NoConnection.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import UIKit

class NoConnectionView: UIView {

    let imageLabel = UIImageView(image: UIImage(named: "no-internet"),contentMode: .scaleAspectFit, clipsToBounds: true)
    let noConnectinLabel = UILabel(text: "No Connection", font: OpenSans.bold, size: 24)
    let errMessage = UILabel(text: "Oops! The internet connection apperars to be offline. Please try again.", font: OpenSans.regular, size: 14,
                             numberOfLines: 0, alignment: .center)
    
    let tryAgainButton = DIButton(buttonTitle: "Try Again", textSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        addSubview(noConnectinLabel)
        noConnectinLabel.centerInSuperview()
        
        addSubview(errMessage)
        errMessage.anchor(top: noConnectinLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 0, bottom: 0, right: 0))
        errMessage.centerXInSuperview()
        
        addSubview(tryAgainButton)
        tryAgainButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 126, right: 13))
        
        addSubview(imageLabel)
        imageLabel.anchor(top: nil, leading: leadingAnchor, bottom: noConnectinLabel.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 144, bottom: 34, right: 145))
    }
}

