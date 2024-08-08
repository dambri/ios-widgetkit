//
//  RepoWatcherWidgetsBundle.swift
//  RepoWatcherWidget
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgetsBundle: WidgetBundle {
    var body: some Widget {
        SingleRepoWidget()
        DoubleRepoWidget()
    }
}
