//
//  ChangeFontIntent.swift
//  Monthly
//
//  Created by Alexandre D'AMBRISI on 08/08/2024.
//

import Foundation
import AppIntents

struct ChangeFontIntent: AppIntent, WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Fun Font"
    static var description: IntentDescription? = .init(stringLiteral: "Switch to a fun font")
    
    @Parameter(title: "Fun Font")
    var funFont: Bool
}
