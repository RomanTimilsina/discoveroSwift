// Copyright © 2021 Minor. All rights reserved.

import UIKit

extension UIButton {
    
    convenience init(buttonImage: UIImage) {
        self.init(type: .system)
        self.imageView?.contentMode = .scaleAspectFit
        self.setImage(buttonImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    convenience init(title: String, titleColor: UIColor?, backgroundColor: UIColor? = nil, font: FontFamily, fontSize: CGFloat, numberOfLines: Int = 1, cornerRadius: CGFloat? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.font(with: fontSize, family: font)
        self.titleLabel?.numberOfLines = numberOfLines
        self.titleLabel?.textAlignment = .center
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        self.backgroundColor = backgroundColor
    }
    
    var tapPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }
}
