// Copyright © 2021 Minor. All rights reserved.

import UIKit
import AVKit

class CameraHandler: NSObject{
    
    static let shared = CameraHandler()
    fileprivate weak var currentVC: UIViewController!
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] response in
            if response {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        let myPickerController = UIImagePickerController()
                        myPickerController.delegate = self
                        myPickerController.sourceType = .camera
                        self.currentVC.present(myPickerController, animated: true, completion: nil)
                    }
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    AlertMessage.showBasicAlertWithCompletion(on: self.currentVC, message: "Please grant access to your camera from the App settings to capture images.") {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: nil)
                        }
                    }
                }
            }
        }
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (alert:UIAlertAction!) -> Void in
            self?.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] (alert:UIAlertAction!) -> Void in
            self?.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel_mobile".localized(), style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickedBlock?(image)
        } else{
            debugPrint("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
}
