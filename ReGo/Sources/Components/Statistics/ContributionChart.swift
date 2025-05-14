//
//  ContributionChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

struct ContributionChartItem: Hashable, Identifiable {
    var id: UUID = UUID()
    var day: Int
    var date: Date
}

struct ContributionChart: View {
    var startDate: Date
    var endDate: Date

    var statPeriod: StatisticsPeriodCase

    var data: [Int: (date: Date, count: Int)]

    @Binding var selectedDay: Int?

    var dayArray: [ContributionChartItem] {
        var result: [ContributionChartItem] = [ContributionChartItem]()

        let calendar = Calendar.current

        var cursor = startDate

        var interval: Double = 0

        var count = 0

        repeat {
            cursor.addTimeInterval(interval)

            let day = calendar.component(.day, from: cursor)

            result.append(.init(day: day, date: cursor))

            interval = 86400

            count += 1
        } while count <= Int(endDate.timeIntervalSince(startDate) / 86400)

        return result
    }

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(dayArray) { (item: ContributionChartItem) in
                let day = item.day
                let date = item.date

                let count = data[day]?.count ?? 0

                let isFutureDate = date > .now

                if statPeriod == .week {
                    WeekContributionItem(count: count, day: day, isFutureDate: isFutureDate, selectedDay: $selectedDay)
                } else {
                    MonthContributionItem(count: count, day: day, isFutureDate: isFutureDate, selectedDay: $selectedDay)

                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 8)
    }
}
