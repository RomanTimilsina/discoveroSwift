//
//  GradientRectangleView.swift
//  Discovero
//
//  Created by admin on 02/11/2023.
//

import UIKit

class GradientRectangleView: UIView {
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupGradient()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupGradient()
  }
  private func setupGradient() {
    if let gradientLayer = self.layer as? CAGradientLayer {
      let startColor = randomColor()
      let endColor = randomColor()
      gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // Left edge
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
  }
    
    private func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
  override func layoutSubviews() {
    super.layoutSubviews()
//    layer.cornerRadius = min(frame.size.width, frame.size.height) / 10
  }
}






