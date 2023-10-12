// Copyright © 2021 Minor. All rights reserved.

import UIKit

extension UILabel {
    convenience init(text: String, color: UIColor? = .white, font: FontFamily, size: CGFloat, numberOfLines: Int? = nil, alignment: NSTextAlignment? = nil) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = UIFont.font(with: size, family: font)
        if let lines = numberOfLines {
            self.numberOfLines = lines
        }
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
    
    func setText(text: String, withLineSpacing lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineSpacing
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        self.attributedText = attrString
    }
    
    
}
