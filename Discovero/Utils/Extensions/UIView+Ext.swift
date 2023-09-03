// Copyright © 2021 Minor. All rights reserved.

import UIKit

extension UIView {
    func dropShadow(radius: CGFloat = 5, color: UIColor = UIColor.black, opacity: Float = 0.2) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
    }
    
    convenience init(color: UIColor?, cornerRadius: CGFloat? = nil) {
        self.init(frame: .zero)
        backgroundColor = color
        if let radius = cornerRadius {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func sendHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
