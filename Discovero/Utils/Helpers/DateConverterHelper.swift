// Copyright © 2021 Minor. All rights reserved.

import Foundation

struct DateConverterHelper {
    static func dateConverter(for date: Date, dateType: DateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        dateFormatter.dateFormat = dateType.value
        dateFormatter.locale = Locale(identifier: "en")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func dateConverter(for date: String, dateType: DateType = DateType.monthDayYear) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        guard let convertedDate = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = dateType.value
        dateFormatter.locale = Locale(identifier: "en")
        let dateString = dateFormatter.string(from: convertedDate)
        return dateString
    }
    
    static func currentDate(format: String = DateType.yearMonthDay.value) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        let todayDate = formatter.string(from: Date())
        return todayDate
    }
    
    static func getCurrentMonth() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "en")
        let nameOfMonth = dateFormatter.string(from: now)
        return nameOfMonth
    }
    
    static func getCurrentMonthNumber() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: now)
        return month
    }
    
    static func getCurrentYear() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        dateFormatter.locale = Locale(identifier: "en")
        let nameOfMonth = dateFormatter.string(from: now)
        return nameOfMonth
    }
    
    static func getCurrentMonthYear() -> (Int, Int) {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return (month, year)
    }
    
    static func getCurrentTime() -> Date? {
        let date = Date()
        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .none
//        dateFormatter.locale = Locale(identifier: "th_TH")
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+07:00")!
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        let time = dateFormatter.date(from: timeString)
        return time
    }
    
    static func getUTCTimeInString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                
        if var convertedDateInUTC = dateFormatter.date(from: date) {
            convertedDateInUTC = convertedDateInUTC.addingTimeInterval(-25200) // 7 hours
            let convertedDateUTCString = dateFormatter.string(from: convertedDateInUTC)
            return convertedDateUTCString
        }
        return ""
    }
    
    static func getConvertedTime(timeAsString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: timeAsString)

        dateFormatter.dateFormat = "HH:mm"
        if let date = date {
            let convertedDate = date.addingTimeInterval(-21600) // +1 hour and +7 for BKK time
            let date24 = dateFormatter.string(from: convertedDate)
            return date24
        }
        return ""
    }
}

enum DateType {
    case yearMonthDay
    case monthDayYear
    case weekDayMonth
    case weekDayMonthYear
    case onlyDay
    case monthYear
    case dateTime
    case dayMonthYear
    case monthDayYearSlashed
    case dayMonthYearSpaces
    case weekMonthDay
    case time
    case monthDay
    
    var value: String {
        switch self {
        case .yearMonthDay: return "yyyy-MM-dd"
        case .monthDayYear: return "MMM dd, yyyy"
        case .weekDayMonth: return "EE, dd MMMM"
        case .weekDayMonthYear: return "EE, dd MMM, yyyy"
        case .onlyDay: return "dd MMM"
        case .monthYear: return "MMMM, yyyy"
        case .dateTime: return "yyyyMMdd/HHmmss"
        case .dayMonthYear: return "dd-MM-yyyy"
        case .monthDayYearSlashed: return "MM/dd/yy"
        case .dayMonthYearSpaces: return "dd MMM yyyy"
        case .weekMonthDay : return "E, MMM dd"
        case .time : return "HH:mm"
        case .monthDay : return "MMM dd"
        }
    }
}
