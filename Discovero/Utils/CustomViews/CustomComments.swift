//
//  CustomComments.swift
//  Discovero
//
//  Created by Mac on 19/09/2023.
//

import UIKit

class CustomComments: UIView {

    let commentersImage = UIImageView(image: UIImage(named: "person") ,contentMode: .scaleAspectFill, clipsToBounds: true)
    let commentersNameLabel = UILabel(text: "Raju Roy", font: OpenSans.semiBold, size: 14, alignment: .left)
    let commentLabel = UILabel(text: "Hi I am interested in this Job. Currently I am staying in Sydney and looking for same type of job. Can you provide more information regarding this offer.", font: OpenSans.regular, size: 14, numberOfLines: 0, alignment: .left)
    let timeSinceCommentLabel = UILabel(text: "\(41) minutes ago", font: OpenSans.regular, size: 12)
    let replyLabel = UILabel(text: "Reply", font: OpenSans.bold, size: 12)
    lazy var commentPartStack = VerticalStackView(arrangedSubViews: [commentersNameLabel, commentLabel], spacing: 5)
    let commentView = UIView()
    lazy var commentsFooter = HorizontalStackView(arrangedSubViews: [timeSinceCommentLabel, replyLabel, UIView()], spacing: 5, distribution: .fill)
    lazy var commentWithFooter = VerticalStackView(arrangedSubViews: [commentView, commentsFooter], spacing: 5)
    let gapView = UIView()
    lazy var commentStack = HorizontalStackView(arrangedSubViews: [gapView, VerticalStackView(arrangedSubViews: [commentersImage, UIView()]), commentWithFooter], spacing: 3)

    init(isReply: Bool = false) {
         super.init(frame: .zero)
        setup()
        if isReply {
            gapView.constraintWidth(constant: 36)
        } else {
            gapView.constraintWidth(constant: 0)
        }
    }
    
    func setup() {
        commentView.addSubview(commentPartStack)
        commentView.backgroundColor = Color.gray800
        commentPartStack.anchor(top: commentView.topAnchor, leading: commentView.leadingAnchor, bottom: commentView.bottomAnchor, trailing: commentView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        commentView.layer.cornerRadius = 5

        commentersImage.constraintHeight(constant: 24)
        commentersImage.constraintWidth(constant: 24)
        commentersImage.layer.cornerRadius = 12


        addSubview(commentStack)
        commentStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
