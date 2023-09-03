//
//  UINavigationController+Ext.swift
//  TMGM
//
//  Created by Sujal Shrestha on 12/06/2023.
//

import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
