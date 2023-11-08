//
//  ConfigureNotificationView.swift
//  Discovero
//
//  Created by Mac on 02/10/2023.
//

import UIKit

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var customData: UIView?
}

class ConfigureNotificationView: UIView {
    
    var handleTap: (() -> Void)?
    var handleClose: (() -> Void)?
    
    let outerView = UIView()
    let innerView = UIView()
    let header = UIView()
    let crossIcon = UIImageView(image: UIImage(named: "crossIcon"),contentMode: .scaleAspectFit)
    let headerLabel = UILabel(text: "Configure Notification", font: OpenSans.regular, size: 14)
    let allowNotifyLabel = UILabel(text: "Allow Notification", font: OpenSans.regular, size: 14)
    let NotifyConditionLabel = UILabel(text: "Notify me if someone", font: OpenSans.regular, size: 14)
    let wantsButton = CustomPopupButtons(buttonsText: "wants")
    let offerButton = CustomPopupButtons(buttonsText: "offer")
    let postTypeLabel = UILabel(text: "a post of type", font: OpenSans.regular, size: 14)
    let RoomButton = CustomPopupButtons(buttonsText: "Room")
    let JobButton = CustomPopupButtons(buttonsText: "Job")
    let SalesButton = CustomPopupButtons(buttonsText: "Sales")
    let stateLabel = UILabel(text: "In State", font: OpenSans.regular, size: 14)
    let StateButton = CustomPopupButtons(buttonsText: "New South Wales")
    let saveButton = DIButton(buttonTitle: "Save")
    let toggleSwitch = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toggleSwitch.isOn = false
        toggleSwitch.thumbTintColor = Color.primary
        toggleSwitch.onTintColor = Color.primary?.withAlphaComponent(0.5)

        setupConstraint()
        saveButton.setInvalidState()
        observeEvents()
    }
    
    func setupConstraint() {
        addSubview(outerView)
        outerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        outerView.backgroundColor = Color.appBlack?.withAlphaComponent(0.5)
        
        outerView.addSubview(innerView)
        innerView.anchor(top: outerView.topAnchor, leading: outerView.leadingAnchor, bottom: nil, trailing: outerView.trailingAnchor, padding: .init(top: 150, left: 50, bottom: 0, right: 50))
        innerView.constraintHeight(constant: 400)
        innerView.constraintWidth(constant: 300)
        innerView.backgroundColor = Color.appBlack
        innerView.layer.cornerRadius = 5
        innerView.clipsToBounds = true
        
        innerView.addSubview(header)
        header.anchor(top: innerView.topAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: innerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        header.backgroundColor = Color.gray500
        header.constraintHeight(constant: 50)
        
        header.addSubview(crossIcon)
        crossIcon.anchor(top: nil, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        crossIcon.centerYInSuperview()
        
        header.addSubview(headerLabel)
        headerLabel.anchor(top: nil, leading: crossIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        headerLabel.centerYInSuperview()

//        headerLabel.centerXAnchor.constraint(equalTo: crossIcon.centerXAnchor).isActive = true
        
        innerView.addSubview(allowNotifyLabel)
        innerView.addSubview(toggleSwitch)
        innerView.addSubview(NotifyConditionLabel)
        innerView.addSubview(postTypeLabel)
        innerView.addSubview(stateLabel)
        innerView.addSubview(saveButton)
        
        allowNotifyLabel.anchor(top: header.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        toggleSwitch.anchor(top: header.bottomAnchor, leading: nil, bottom: nil, trailing: innerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 5))
        
        NotifyConditionLabel.anchor(top: allowNotifyLabel.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        innerView.addSubview(wantsButton)
        wantsButton.anchor(top: NotifyConditionLabel.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        wantsButton.constraintHeight(constant: 24)
//        wantsButton.constraintWidth(constant: 100)

        innerView.addSubview(offerButton)
        offerButton.anchor(top: NotifyConditionLabel.bottomAnchor, leading: wantsButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        offerButton.constraintHeight(constant: 24)
//        wantsButton.constraintWidth(constant: 100)
        
        postTypeLabel.anchor(top: offerButton.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        innerView.addSubview(RoomButton)
        RoomButton.anchor(top: postTypeLabel.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        RoomButton.constraintHeight(constant: 24)
        
        innerView.addSubview(JobButton)
        JobButton.anchor(top: postTypeLabel.bottomAnchor, leading: RoomButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        JobButton.constraintHeight(constant: 24)
        
        innerView.addSubview(SalesButton)
        SalesButton.anchor(top: postTypeLabel.bottomAnchor, leading: JobButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        SalesButton.constraintHeight(constant: 24)
        
        stateLabel.anchor(top: SalesButton.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        innerView.addSubview(StateButton)
        StateButton.anchor(top: stateLabel.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        StateButton.constraintHeight(constant: 24)
        
        saveButton.anchor(top: StateButton.bottomAnchor, leading: innerView.leadingAnchor, bottom: nil, trailing: innerView.trailingAnchor, padding: .init(top: 40, left: 12, bottom: 0, right: 12))
    }
    
    func observeEvents() {
            let allButtons = [wantsButton, offerButton, RoomButton, JobButton, SalesButton, StateButton]
            
            toggleSwitch.addTarget(self, action: #selector(toggleFunction), for: .valueChanged)
            
            for button in allButtons {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
                button.parentView = self // Set the parent view reference
                button.addGestureRecognizer(gesture)
                button.isUserInteractionEnabled = true
            }
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(onClose))
        crossIcon.addGestureRecognizer(closeGesture)
        crossIcon.isUserInteractionEnabled = true
        }

    @objc func onClose() {
            handleClose?()
        }
    
    @objc func tapped(_ gesture: UITapGestureRecognizer) {
            if let tappedButton = (gesture.view as? CustomPopupButtons) {
                // Use the 'tappedButton' parameter as needed
                if tappedButton.activated {
                    tappedButton.ticked = !tappedButton.ticked
                }
                tappedButton.updateButtonAppearance()
            }
        }

    @objc func toggleFunction() {
        if toggleSwitch.isOn {
            activateDeactivate()
            saveButton.setValidState()
        } else {
            activateDeactivate()
            saveButton.setInvalidState()
        }
    }
    
    func activateDeactivate() {
        wantsButton.toggle()
        offerButton.toggle()
        RoomButton.toggle()
        JobButton.toggle()
        SalesButton.toggle()
        StateButton.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
