//
//  ContributorEntryView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import SwiftUI
import WidgetKit

struct ContributorEntryView: View {
    var entry: ContributorEntry

    var body: some View {
        VStack {
            Text(entry.date.formatted())
        }
        .containerBackground(for: .widget) {
            
        }
    }
}

struct ContributorEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ContributorEntryView(entry: ContributorEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
