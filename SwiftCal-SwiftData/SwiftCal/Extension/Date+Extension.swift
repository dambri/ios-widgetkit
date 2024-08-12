//
//  Date+Extension.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    var endOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.end
    }

    var endOfDay: Date {
        Calendar.current.dateInterval(of: .day, for: self)!.end
    }

    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }

    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }

    var numberOfDaysInMonth: Int {
        // endOfMonth returns the 1st of next month at midnight.
        // An adjustment of -1 is necessary to get last day of current month
        let endDateAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: self.endOfMonth)!
        return Calendar.current.component(.day, from: endDateAdjustment)
    }

    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }

    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }

    var monthFullName: String {
        self.formatted(.dateTime.month(.wide))
    }
    
    var startOfCalendarWithPrefixDays: Date {
        let startOfMonthWeekDay = Calendar.current.component(.weekday, from: startOfMonth)
        let numberOfPrefixDays = startOfMonthWeekDay - 1
        let starDate = Calendar.current.date(byAdding: .day, value: -numberOfPrefixDays, to: startOfMonth)!
        return starDate
    }
}
