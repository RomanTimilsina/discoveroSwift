////
////  CreateRentView.swift
////  Ejyalo
////
////  Created by sujal on 22/06/2023.
////
//
//import UIKit
//
//class CreateRentView : BaseView {
//    
//    var createRent: ((PostCreateRentListModel) -> Void)?
//    var dateRent: ((String,String) -> Void)?
//    
//    let currentView = UIView()
//    let rentView = UIView()
//    let yearView = UIButton()
//    let monthView = UIButton()
//    let tableView = UIView()
//    let monthTableView = UIView()
//    var handleYearLabel :(() -> Void)?
//    var handleMonthLabel : (() -> Void)?
//    var handleCreateButtonClick: (() -> Void)?
//    
//    let info = ["Rent will be create from today date to end of this month"]
//    
//    var monthIntValue: Int = 2
//    
//    enum Year: Int, CaseIterable {
//        case year2079 = 2079
//        case year2080 = 2080
//        case year2081 = 2081
//        
//        var stringValue: String {
//            return String(rawValue)
//        }
//    }
//    
//    enum Month {
//        case baisakh
//        case jestha
//        case asadh
//        case shrawan
//        case bhadra
//        case ashwin
//        case kartik
//        case mangshir
//        case poush
//        case magh
//        case falgun
//        case chaitra
//        
//        var stringValue: String {
//            switch self {
//            case .baisakh: return "Baisakh"
//            case .jestha: return "Jestha"
//            case .asadh: return "Asadh"
//            case .shrawan: return "Shrawan"
//            case .bhadra: return "Bhadra"
//            case .ashwin: return "Ashwin"
//            case .kartik: return "Kartik"
//            case .mangshir: return "Mangsir"
//            case .poush: return "Poush"
//            case .magh: return "Magh"
//            case .falgun: return "Falgun"
//            case .chaitra: return "Chaitra"
//            }
//        }
//        
//        var intValue: Int {
//            switch self {
//            case .baisakh: return 1
//            case .jestha: return 2
//            case .asadh: return 3
//            case .shrawan: return 4
//            case .bhadra: return 5
//            case .ashwin: return 6
//            case .kartik: return 7
//            case .mangshir: return 8
//            case .poush: return 9
//            case .magh: return 10
//            case .falgun: return 11
//            case .chaitra: return 12
//            }
//        }
//    }
//    
//    let headerLogo : UIImageView = {
//        let logo = UIImageView()
//        logo.image = UIImage(named: "ejyalo")
//        logo.contentMode = .scaleAspectFit
//        return logo
//    }()
//    
//    let backButton = UIButton(buttonImage: UIImage(named: "back")?.withTintColor(.whiteColor, renderingMode: .alwaysOriginal) ?? UIImage())
//    
//    let createRentLabel = UILabel(text: "Create Rent", color: .white, font: CustomFont.bold.of(.customHeading(size: 20)), numberOfLines: 0)
//    
//    let infoIcon = UIButton(buttonImage: UIImage(systemName: "info.circle.fill")?.withTintColor(.whiteColor, renderingMode: .alwaysOriginal) ?? UIImage())
//    
//    let infoLabel = UILabel()
//    
//    let roomCodeLabel = UILabel(text: "Room Code: ", color: .textColor, font: CustomFont.regular.of(.heading1), numberOfLines: 0)
//    
//    let roomCodeValueLabel = UILabel(text: "", color: .textColor, font: CustomFont.regular.of(.heading1), numberOfLines: 0)
//    
//    let tenantNameLabel = UILabel(text: "Tenant Name: ", color: .textColor, font: CustomFont.regular.of(.heading1), numberOfLines: 0)
//    
//    let tenantNameValueLabel = UILabel(text: "", color: .textColor, font: CustomFont.regular.of(.heading1), numberOfLines: 0)
//    
//    let selectYearLabel = UILabel(text: "Select Year*", color: .white, font: CustomFont.regular.of(.customHeading(size: 18)), numberOfLines: 0)
//    
//    let dropIconYear = UIButton(buttonImage: UIImage(named: "down") ?? UIImage())
//    
//    let dropIconMonth = UIButton(buttonImage: UIImage(named: "down") ?? UIImage())
//    
//    let yearLabel = UILabel(text: "2080", color: .black, font: CustomFont.regular.of(.customHeading(size: 16)), numberOfLines: 0)
//    
//    let selectMonthLabel = UILabel(text: "Select Month*", color: .white, font: CustomFont.regular.of(.customHeading(size: 18)), numberOfLines: 0)
//    
//    let monthLabel = UILabel(text: "Jestha", color: .black, font: CustomFont.regular.of(.customHeading(size: 16)), numberOfLines: 0)
//    
//    let remarksLabel = UILabel(text: "Remarks*", color: .white, font: CustomFont.regular.of(.customHeading(size: 16)), numberOfLines: 0)
//    
//    let remarksTextField = EjyaloTextField(fieldType: .compulsory, title: "Remarks")
//    
//    let createRentButton = UIButton(title: "Create Rent", titleColor: .white, backgroundColor: .appBackgroundColor, fontSize: 18)
//    
//    lazy var yearMonthLabelHorizontalStack = HorizontalStackView(arrangedSubViews: [selectYearLabel, selectMonthLabel], spacing: 20)
//    
//    lazy var yearMonthViewHorizontalStack = HorizontalStackView(arrangedSubViews: [yearView, monthView], spacing: 20)
//    
//    lazy var createRentVerticalStack = VerticalStackView(arrangedSubViews: [rentView,
//                                                                            yearMonthLabelHorizontalStack,
//                                                                            yearMonthViewHorizontalStack,
//                                                                            remarksLabel,
//                                                                            remarksTextField], spacing: 16)
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//        observeViewEvents()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupView(){
//        addSubview(headerLogo)
//        headerLogo.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
//        headerLogo.constraintHeight(constant: 50)
//        headerLogo.centerXInSuperview()
//        
//        addSubview(backButton)
//        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 4, bottom: 0, right: 0))
//        backButton.constraintWidth(constant: 52)
//        backButton.constraintHeight(constant: 42)
//        backButton.imageView?.contentMode = .scaleAspectFit
//        backButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 12, right: 16)
//        
//        addSubview(currentView)
//        currentView.anchor(top: headerLogo.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 10, right: 10))
//        currentView.layer.cornerRadius = 8
//        currentView.backgroundColor = .secondaryBackgroundColor
//        currentView.layer.borderWidth = 0.5
//        currentView.layer.borderColor = UIColor.secondaryBackgroundColor.cgColor
//        
//        currentView.addSubview(createRentLabel)
//        createRentLabel.anchor(top: currentView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
//        createRentLabel.centerXAnchor.constraint(equalTo: currentView.centerXAnchor).isActive = true
//        
//        currentView.addSubview(infoIcon)
//        infoIcon.anchor(top: currentView.topAnchor, leading: nil, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 16))
//        infoIcon.constraintHeight(constant: 24)
//        infoIcon.constraintWidth(constant: 24)
//        
//        currentView.addSubview(rentView)
//        rentView.anchor(top: createRentLabel.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 20, right: 12))
//        rentView.layer.cornerRadius = 8
//        rentView.backgroundColor = .buttonColor
//        rentView.layer.borderWidth = 0.5
//        rentView.layer.borderColor = UIColor.white.cgColor
//        rentView.constraintHeight(constant: 80)
//        
//        rentView.addSubview(roomCodeLabel)
//        roomCodeLabel.anchor(top: rentView.topAnchor, leading: rentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 14, left: 10, bottom: 0, right: 0))
//        
//        rentView.addSubview(roomCodeValueLabel)
//        roomCodeValueLabel.anchor(top: rentView.topAnchor, leading: roomCodeLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 14, left: 6, bottom: 0, right: 0))
//        
//        rentView.addSubview(tenantNameLabel)
//        tenantNameLabel.anchor(top: roomCodeLabel.bottomAnchor, leading: rentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
//        
//        rentView.addSubview(tenantNameValueLabel)
//        tenantNameValueLabel.anchor(top: roomCodeLabel.bottomAnchor, leading: tenantNameLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 6, bottom: 0, right: 0))
//        
//        currentView.addSubview(selectYearLabel)
//        selectYearLabel.anchor(top: rentView.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
//        
//        currentView.addSubview(yearView)
//        yearView.anchor(top: selectYearLabel.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 12, bottom: 30, right: 10))
//        yearView.layer.cornerRadius = 12
//        yearView.backgroundColor = .white
//        yearView.layer.borderWidth = 0.5
//        yearView.layer.borderColor = UIColor.white.cgColor
//        yearView.constraintHeight(constant: 40)
//        yearView.constraintWidth(constant: 120)
//        
//        yearView.addSubview(yearLabel)
//        yearLabel.anchor(top: yearView.topAnchor, leading: yearView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
//        
//        yearView.addSubview(dropIconYear)
//        dropIconYear.anchor(top: yearView.topAnchor, leading: nil, bottom: nil, trailing: yearView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10))
//        dropIconYear.constraintHeight(constant: 16)
//        dropIconYear.constraintWidth(constant: 20)
//        
//        currentView.addSubview(selectMonthLabel)
//        selectMonthLabel.anchor(top: rentView.bottomAnchor, leading: nil, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 12, left: 65, bottom: 0, right: 76))
//        
//        currentView.addSubview(monthView)
//        monthView.anchor(top: selectMonthLabel.bottomAnchor, leading: yearView.trailingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 8, left: 12, bottom: 20, right: 12))
//        monthView.layer.cornerRadius = 12
//        monthView.backgroundColor = .white
//        monthView.layer.borderWidth = 0.5
//        monthView.layer.borderColor = UIColor.white.cgColor
//        monthView.constraintHeight(constant: 40)
//        
//        monthView.addSubview(monthLabel)
//        monthLabel.anchor(top: monthView.topAnchor, leading: monthView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
//        
//        monthView.addSubview(dropIconMonth)
//        dropIconMonth.anchor(top: monthView.topAnchor, leading: nil, bottom: nil, trailing: monthView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10))
//        dropIconMonth.constraintHeight(constant: 16)
//        dropIconMonth.constraintWidth(constant: 20)
//        
//        currentView.addSubview(yearMonthLabelHorizontalStack)
//        yearMonthLabelHorizontalStack.anchor(top: rentView.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 36))
//        
//        currentView.addSubview(yearMonthViewHorizontalStack)
//        yearMonthViewHorizontalStack.anchor(top: yearMonthLabelHorizontalStack.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
//        
//        currentView.addSubview(createRentVerticalStack)
//        createRentVerticalStack.anchor(top: createRentLabel.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 01, right: 16))
//        
//        currentView.addSubview(createRentButton)
//        createRentButton.anchor(top: createRentVerticalStack.bottomAnchor, leading: currentView.leadingAnchor, bottom: nil, trailing: currentView.trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12))
//        createRentButton.constraintHeight(constant: 42)
//        createRentButton.layer.cornerRadius = 16
//    }
//    
//    private func observeViewEvents() {
//        if #available(iOS 14.0, *) {
//            infoIcon.showsMenuAsPrimaryAction = true
//            infoIcon.menu = addInfoMenu()
//            yearView.showsMenuAsPrimaryAction = true
//            yearView.menu = addYearMenu()
//            monthView.showsMenuAsPrimaryAction = true
//            monthView.menu = addMonthMenu()
//        } else {
//            // Fallback on earlier versions
//        }
//        createRentButton.addTarget(self, action: #selector(handleCreateRentButton), for: .touchUpInside)
//    }
//    
//    @objc func handleCreateRentButton(){
//        handleCreateButtonClick?()
//        createRent?(PostCreateRentListModel(room: "",
//                                            year: yearLabel.text,
//                                            month: String(monthIntValue),
//                                            remarks: remarksTextField.field.text))
//    }
//    
//    private func addInfoMenu() -> UIMenu {
//       let actionTitle = "Rent will be created from current date to end of current running month."
//        let infoMenuItem = UIAction(title: actionTitle, handler: { _ in
//        })
//        let infoMenu = UIMenu(title: "", children: [infoMenuItem])
//        return infoMenu
//    }
//    
//    private func addYearMenu() -> UIMenu {
//        let yearMenu = UIMenu(title: "", children: createYearMenuOptions())
//        return yearMenu
//    }
//    
//    private func createYearMenuOptions() -> [UIAction] {
//        return Year.allCases.map { option in
//            UIAction(title: "\(option.rawValue)", image: nil, identifier: nil) { _ in
//                self.yearLabel.text = "\(option.rawValue)"
//            }
//        }
//    }
//    
//    private func addMonthMenu() -> UIMenu {
//        let monthMenu = UIMenu(title: "", children: createMonthMenuOptions())
//        return monthMenu
//    }
//    
//    private func createMonthMenuOptions() -> [UIAction] {
//        return [
//            Month.baisakh,
//            Month.jestha,
//            Month.asadh,
//            Month.shrawan,
//            Month.bhadra,
//            Month.ashwin,
//            Month.kartik,
//            Month.mangshir,
//            Month.poush,
//            Month.magh,
//            Month.falgun,
//            Month.chaitra
//        ].map { month in
//            UIAction(title: month.stringValue, image: nil, identifier: nil) { _ in
//                self.monthLabel.text = month.stringValue
//                self.monthIntValue = month.intValue
//            }
//        }
//    }
//    
//    func configView(data: PostCreateRentListModel){
//        monthLabel.text = data.month
//        yearLabel.text = data.year
//        dateRent?(yearLabel.text ?? "", monthLabel.text ?? "")
//    }
//}
//
//
