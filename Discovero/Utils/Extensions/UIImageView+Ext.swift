// Copyright © 2021 Minor. All rights reserved.

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode, clipsToBounds: Bool = false) {
        self.init(frame: .zero)
        self.contentMode = contentMode
        self.clipsToBounds = clipsToBounds
        self.image = image
    }
}
