////
////  CustmPushPopTransition.swift
////  Discovero
////
////  Created by Mac on 06/11/2023.
////
//
//import Foundation
//import UIKit
//
//class CustomPushPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
//    var isPresenting: Bool = true
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5 // Duration of the animation
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: .from)
//        let toView = transitionContext.view(forKey: .to)
//
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let toVC = transitionContext.viewController(forKey: .to)
//
//        if isPresenting {
//            // Define animation for presenting
//            containerView.addSubview(toView!)
//
//            toView!.frame.origin.x = toView!.frame.size.width
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                toView!.frame.origin.x = 0
//                fromView!.frame.origin.x = -fromView!.frame.size.width
//            }, completion: { _ in
//                transitionContext.completeTransition(true)
//            })
//        } else {
//            // Define animation for dismissing
//            containerView.addSubview(toView!)
//
//            toView!.frame.origin.x = -toView!.frame.size.width
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                toView!.frame.origin.x = 0
//                fromView!.frame.origin.x = fromView!.frame.size.width
//            }, completion: { _ in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            })
//        }
//    }
//}
