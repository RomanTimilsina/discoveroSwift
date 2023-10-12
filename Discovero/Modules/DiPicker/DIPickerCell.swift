import Foundation
import UIKit

class DIPickerCell: UITableViewCell {
    
    static let identifier  = "pickerTableCell"
    
    var passCheck: ((Bool) -> Void)?
    var passpass: (() -> Void)?
    
    let countryImage = UIImageView(image: UIImage(), contentMode: .scaleAspectFit, clipsToBounds: true)
    let countryName = UILabel(text: "", font: OpenSans.regular, size: 14)
    var isChecked = false
    var countCheck = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Color.gray900
        setupConstraints()
        observeConstraints()
        
        check()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(countryImage)
        countryImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        countryImage.constraintWidth(constant: 25)
        countryImage.constraintHeight(constant: 25)
        countryImage.centerYInSuperview()
        
        addSubview(countryName)
        countryName.anchor(top: nil, leading: countryImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        countryName.centerYInSuperview()
    }
    
    func observeConstraints() {
        let checkUncheck = UITapGestureRecognizer(target: self, action: #selector(checkManage))
        countryImage.addGestureRecognizer(checkUncheck)
        countryImage.isUserInteractionEnabled = true
    }
    
    @objc func check() {
        passpass?()
        
    }
    
    @objc func checkManage() {
        isChecked = !isChecked
        passCheck?(isChecked)
    }
    
    func configureData(data: NewCountryModel) {
        countryName.text = data.name
        countryImage.image = data.flagImage
        countryImage.tintColor = .clear
    }
    
    func configureLanguageData(data: LanguageModel) {
        countryName.text = data.language
        isChecked = data.isSelected!
        //initially data.isSelected = false as nothing yet selected
        countryImage.image = data.isSelected! ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        countryImage.tintColor = Color.primary
    }
}
