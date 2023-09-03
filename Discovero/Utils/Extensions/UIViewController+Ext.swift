// Copyright © 2021 Minor. All rights reserved.

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func add(_ child: UIViewController, innerView: UIView? = nil) {
        addChild(child)
        if innerView == nil {
            view.addSubview(child.view)
        } else {
            innerView!.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func showHUD() {
        /// Make sure we're not already showing a HUD.
        guard MBProgressHUD.forView(view) == nil else { return }
        let indicator = MBProgressHUD.showAdded(to: view, animated: true)
        indicator.contentColor = Color.primary
        indicator.bezelView.style = .blur
        indicator.show(animated: true)
    }

    /// Removes all presented HUDs.
    func hideHUD() {
        while let hud = MBProgressHUD.forView(view) {
            hud.hide(animated: true)
        }
    }
    
    func getJSONString(dictionary: [String:String]) -> String? {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            return theJSONText
        }
        return nil
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "ok_mobile".localized(),
                         cancelTitle:String? = "cancel_mobile".localized(),
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((String) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?("")
                return
            }
            actionHandler?(textField.text ?? "")
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
