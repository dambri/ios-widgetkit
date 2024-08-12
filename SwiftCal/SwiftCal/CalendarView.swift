//
//  ContentView.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
        predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)",
                               Date().startOfCalendarWithPrefixDays as CVarArg,
                               Date().endOfMonth as CVarArg))
    private var days: FetchedResults<Day>
    private let daysOfWeek = Calendar.current.veryShortWeekdaySymbols

    var body: some View {
        NavigationView {
            VStack {
                CalendarHeaderView()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), content: {
                    ForEach(days) { day in
                        if day.date!.monthInt != Date().monthInt {
                            Text("")
                        } else {
                            Text(day.date!.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(day.didStudy ? .orange : .secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    Circle()
                                        .foregroundStyle(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                )
                                .onTapGesture {
                                    if day.date!.dayInt <= Date().dayInt {
                                        day.didStudy.toggle()
                                        do {
                                            try viewContext.save()
                                            print("☝🏻 \(day.date!.dayInt) now studied")
                                        } catch {
                                            print("❌ ERROR: Failed to save context")
                                        }
                                    } else {
                                        print("Can't study in the future!")
                                    }
                                }
                        }
                    }
                })
                
                Spacer()
            }
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .padding()
            .onAppear {
                if days.isEmpty {
                    createMonthDays(for: .now.startOfPreviousMonth)
                    createMonthDays(for: .now)
                } else if days.count < 10 { // iIs this ONLY the prefix days
                    createMonthDays(for: .now)
                }
            }
        }
    }
    
    private func createMonthDays(for date: Date) {
        for dayOffset in 0..<date.numberOfDaysInMonth {
            let newDay = Day()
            newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)
            newDay.didStudy = false
        }
        
        do {
            try viewContext.save()
            print("✅ \(date.monthFullName) days created")
        } catch {
            print("❌ ERROR: Failed to save context")
        }
    }
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
