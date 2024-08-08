//
//  ContributorMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 08/08/2024.
//

import SwiftUI
import WidgetKit

struct ContributorMediumView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Top Contributors")
                    .font(.caption).bold()
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), alignment: .leading, spacing: 20) {
                ForEach(0..<4) { item in
                    HStack {
                        Image(uiImage: UIImage(named: "avatar")!)
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("Sean Allen")
                                .font(.caption)
                                .minimumScaleFactor(0.7)
                            
                            Text("42")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding()
        .containerBackground(for: .widget) {
            
        }
    }
}

struct ContributorMediumView_Previews: PreviewProvider {
    static var previews: some View {
        ContributorMediumView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
