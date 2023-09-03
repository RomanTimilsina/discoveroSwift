// Copyright © 2021 Minor. All rights reserved.

import Foundation

struct TimeFormatter {
    static func getMinuteSeconds(time: Int) -> String {
        let minutes = (time) / 60 % 60
        let seconds = (time) % 60
        return String(format:"%02i: %02i", minutes, seconds)
    }
}
