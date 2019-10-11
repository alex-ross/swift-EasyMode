import Foundation

extension Date {
    public var startOfWeek: Date {
       return previous(.monday, considerToday: true)
    }

    public var endOfWeek: Date {
        return next(.sunday, considerToday: true)
    }

    public var isoDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "CET")!

        return formatter.string(from: self)
    }
}

extension Date {

    public static func today() -> Date {
        return Date()
    }

    public func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }

    public func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }

    public func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {

        let dayName = weekDay.rawValue

        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

        let calendar = Calendar(identifier: .gregorian)

        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }

        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex


        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)

        return date!
    }

}

// MARK: Helper methods
extension Date {
    public func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }

    public enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }

    public enum SearchDirection {
        case next
        case previous

        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}
