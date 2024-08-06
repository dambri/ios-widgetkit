//
//  Date+Extension.swift
//  Monthly
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import Foundation

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
    
    var monthDisplayFormat: String {
        self.formatted(.dateTime.month(.wide))
    }
}
