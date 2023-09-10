//
//  DIPickerCell.swift
//  Discovero
//
//  Created by Mac on 06/09/2023.
//

import Foundation
import UIKit

class DIPickerCell: UITableViewCell {
    
    static let identifier  = "pickerTableCell"
    
    let countryImage = UIImageView(image: UIImage(),contentMode: .scaleAspectFit, clipsToBounds: true)
    let countryName = UILabel(text: "", font: OpenSans.regular, size: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Color.gray900
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints() {
        addSubview(countryImage)
        countryImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        countryImage.centerYInSuperview()
        
        addSubview(countryName)
        countryName.anchor(top: nil, leading: countryImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        countryName.centerYInSuperview()
    }
    
    func configureData(data: DIPickerModel) {
        countryImage.image = data.countryImage
        countryName.text = data.countryName
    }
}
