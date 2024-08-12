//
//  Day.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//
//

import Foundation
import SwiftData


@Model public class Day {
    var date: Date
    var didStudy: Bool
    
    init(date: Date, didStudy: Bool) {
        self.date = date
        self.didStudy = didStudy
    }
}
