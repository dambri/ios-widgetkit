//
//  MonthConfig.swift
//  MonthlyWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import Foundation
import SwiftUI

struct MonthConfig {
    let backgroundColor: Color
    let emojiText: String
    let monthTextColor: Color
    let dayTextColor: Color
    let shadowColor: Color

    static func determineConfig(from date: Date) -> MonthConfig {
        let monthInt = Calendar.current.component(.month, from: date)

        switch monthInt {
            case 1:
                return MonthConfig(backgroundColor: .gray,
                                   emojiText: "⛄️",
                                   monthTextColor: .black.opacity(0.6),
                                   dayTextColor: .white.opacity(0.8), 
                                   shadowColor: .black)
            case 2:
                return MonthConfig(backgroundColor: .palePink,
                                   emojiText: "❤️",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .pink.opacity(0.8),
                                   shadowColor: .black)
            case 3:
                return MonthConfig(backgroundColor: .paleGreen,
                                   emojiText: "☘️",
                                   monthTextColor: .black.opacity(0.7),
                                   dayTextColor: .darkGreen.opacity(0.8),
                                   shadowColor: .black)
            case 4:
                return MonthConfig(backgroundColor: .paleBlue,
                                   emojiText: "☔️",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .purple.opacity(0.8),
                                   shadowColor: .black)
            case 5:
                return MonthConfig(backgroundColor: .paleYellow,
                                   emojiText: "🌺",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .pink.opacity(0.7),
                                   shadowColor: .black)
            case 6:
                return MonthConfig(backgroundColor: .skyBlue,
                                   emojiText: "🌤",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .paleYellow.opacity(0.8),
                                   shadowColor: .black)
            case 7:
                return MonthConfig(backgroundColor: .blue,
                                   emojiText: "🏖",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .paleBlue.opacity(0.8), 
                                   shadowColor: .black)
            case 8:
                return MonthConfig(backgroundColor: .paleOrange,
                                   emojiText: "☀️",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .darkOrange.opacity(0.8),
                                   shadowColor: .black)
            case 9:
                return MonthConfig(backgroundColor: .paleRed,
                                   emojiText: "🍁",
                                   monthTextColor: .black.opacity(0.5),
                                   dayTextColor: .paleYellow.opacity(0.9),
                                   shadowColor: .black)
            case 10:
                return MonthConfig(backgroundColor: .black,
                                   emojiText: "👻",
                                   monthTextColor: .white.opacity(0.6),
                                   dayTextColor: .orange.opacity(0.8),
                                   shadowColor: .white)
            case 11:
                return MonthConfig(backgroundColor: .paleBrown,
                                   emojiText: "🦃",
                                   monthTextColor: .black.opacity(0.6),
                                   dayTextColor: .black.opacity(0.6),
                                   shadowColor: .black)
            case 12:
                return MonthConfig(backgroundColor: .paleRed,
                                   emojiText: "🎄",
                                   monthTextColor: .white.opacity(0.9),
                                   dayTextColor: .darkGreen.opacity(0.7),
                                   shadowColor: .black)
            default:
                return MonthConfig(backgroundColor: .gray,
                                   emojiText: "📅",
                                   monthTextColor: .black.opacity(0.6),
                                   dayTextColor: .white.opacity(0.8),
                                   shadowColor: .white)
        }
    }
}
