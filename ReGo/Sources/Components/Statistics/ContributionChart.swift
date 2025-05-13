//
//  ContributionChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

struct ContributionChart: View {
    var startDate: Date
    var endDate: Date

    var statPeriod: StatisticsPeriodCase

    var data: [Retrospect]

    @Binding var selectedDay: Int?

    var dayArray: [Int] {
        var result: [Int] = [Int]()

        let calendar = Calendar.current

        var curosor = startDate

        var interval: Double = 0

        var count = 0

        repeat {
            curosor.addTimeInterval(interval)

            let day = calendar.component(.day, from: curosor)

            result.append(day)

            interval = 86400

            count += 1
        } while count <= Int(endDate.timeIntervalSince(startDate) / 86400)

        return result
    }

    var filteredData: [Int: Int] {
        let calendar: Calendar = Calendar.current

        return data
            .reduce(into: [:]) { result, item in
                let day = calendar.component(.day, from: item.date)

                result[day, default: 0] += 1
            }
    }

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(dayArray, id: \.self) { day in
                let count = filteredData[day] ?? 0

                if statPeriod == .week {
                    WeekContributionItem(count: count, day: day, selectedDay: selectedDay)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if selectedDay == day {
                                    selectedDay = nil
                                } else {
                                    selectedDay = day
                                }
                            }
                        }
                } else {
                    MonthContributionItem(count: count, day: day)
                }

            }
        }
        .padding(.vertical)
        .padding(.horizontal, 8)
    }
}
