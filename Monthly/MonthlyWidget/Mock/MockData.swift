//
//  MockData.swift
//  Monthly
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import Foundation

struct MockData {
    static let dataOne = DayEntry(date: dateToDisplay(month: 7, day: 11))
    static let dataTwo = DayEntry(date: dateToDisplay(month: 10, day: 26))
    static let dataThree = DayEntry(date: dateToDisplay(month: 12, day: 25))
    static let dataFour = DayEntry(date: dateToDisplay(month: 4, day: 5))
    static let dataFive = DayEntry(date: dateToDisplay(month: 1, day: 18))
    
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current, year: 2024, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
