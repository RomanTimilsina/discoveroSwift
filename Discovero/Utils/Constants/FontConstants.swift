// Copyright © 2021 Minor. All rights reserved.

import UIKit

typealias AppFont = UIFont

extension AppFont {
    static func font(with size: CGFloat, family: FontFamily?) -> AppFont {
        guard let family = family, let requiredFont = UIFont(name: family.value, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return requiredFont
    }
}

protocol FontFamily {
    var value: String { get }
}

enum Mulish: FontFamily {
    case regular
    case bold
    case semiBold
    case black
    
    var value: String {
        switch self {
            case .regular: return "Mulish-Regular"
            case .bold: return "Mulish-Bold"
            case .semiBold: return "Mulish-SemiBold"
            case .black: return "Mulish-Black"
        }
    }
}
