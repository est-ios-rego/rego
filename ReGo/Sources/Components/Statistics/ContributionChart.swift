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

    var weekdayHeader: some View {
        ForEach(0 ..< 7) { weekday in
            Text(Calendar.current.shortWeekdaySymbols[weekday])
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
    }

    var emptyItem: some View {
        let firstWeekday = Calendar.current.getFirstWeekDayOfMonth(in: startDate)

        return ForEach(0 ..< firstWeekday - 1, id: \.self) { _ in
            Spacer()
        }
    }

    var contributionItem: some View {
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

    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7)) {
            weekdayHeader

            if statPeriod == .month {
                emptyItem
            }

            contributionItem
        }
        .padding(.vertical)
        .padding(.horizontal, 8)
    }
}
