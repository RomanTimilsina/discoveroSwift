//
//  MyProfileCell.swift
//  Discovero
//
//  Created by Mac on 10/09/2023.
//

import UIKit

class MyProfileCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    let titleLabel = UILabel(text: "FullName", font: OpenSans.semiBold, size: 14, alignment: .left)
    let valueLabel = UILabel(text: "Ankit Chaudhary", font: OpenSans.regular, size: 14, alignment: .left)
    let  emptyView = UIView()
    lazy var stack = VerticalStackView(arrangedSubViews: [UIView(), titleLabel,emptyView, valueLabel], spacing: 0, distribution: .fill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        superCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func superCellView() {
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func configureData(data: profileModel){
        emptyView.isHidden = true
        titleLabel.text = data.title
        valueLabel.text = data.value
    }
    
    func configureEmptyCell() {
        emptyView.isHidden = false
        emptyView.constraintHeight(constant: 3)
        emptyView.centerXInSuperview()
        titleLabel.text = ""
        valueLabel.text = ""
        emptyView.backgroundColor = .gray
    }
}
