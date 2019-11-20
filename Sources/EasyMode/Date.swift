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

        return formatter.string(from: self)
    }
    public var iso8601Date: String { isoDate }

    public var iso8601: String {
        if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
            return ISO8601DateFormatter.string(from: self, timeZone: TimeZone.current, formatOptions: .withInternetDateTime)
        } else {
            var buffer = [CChar](repeating: 0, count: 25)
            var time = time_t(self.timeIntervalSince1970)
            strftime_l(&buffer, buffer.count, "%FT%T%z", localtime(&time), nil)
            return String(cString: buffer)
        }
    }

    public static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = Calendar(identifier: .gregorian)

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }

    public static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
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
