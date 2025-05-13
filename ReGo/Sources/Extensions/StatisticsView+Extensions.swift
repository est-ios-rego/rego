//
//  StatisticsView+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation

extension StatisticsView {
    var dataFilteredByPeriod: [Retrospect] {
        return self.data.filter {
            return $0.date >= self.baseStartDate && $0.date <= self.baseEndDate
        }
    }

    var dataFilteredByDay: [Retrospect] {
        let calendar = Calendar.current

        return data.filter {
            selectedDay == calendar.component(.day, from: $0.date)
        }
    }

    var dataCountByDay: [Int: Int] {
        let calendar: Calendar = Calendar.current

        return dataFilteredByPeriod
            .reduce(into: [:]) { result, item in
                let day = calendar.component(.day, from: item.date)

                result[day, default: 0] += 1
            }
    }

    var moodChartData: [MoodChartItem] {
        var moodChartItems = [MoodChartItem]()

        let countDict = dataFilteredByDay.reduce(into: [:]) {
            $0[$1.mood, default: 0] += 1
        }

        for item in countDict {
            moodChartItems.append(MoodChartItem(emoji: item.key.emoji, count: item.value, color: item.key.color))
        }

        return moodChartItems
    }

    var weekOfMonth: String {
        let calendar = Calendar.current

        let year = calendar.component(.year, from: baseStartDate)
        let month = calendar.component(.month, from: baseStartDate)
        let day = calendar.component(.day, from: baseStartDate)

        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1, hour: 9))!

        let firstThursday = (5 - (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7) % 7 + 1

        let daysSinceFirstThursday = day - firstThursday

        let weekNumber = (daysSinceFirstThursday / 7) + 1

        return numOfWeekKr[weekNumber - 1]
    }

    var weekdayRange: Range<Int> {
        Calendar.current.component(.day, from: baseStartDate) ..< Calendar.current.component(.day, from: baseEndDate) + 1
    }

    func moveDate(_ flag: String) {
        let calendar = Calendar.current

        defer {
            selectedDay = nil
        }

        var nextStartDate: Date = .now
        var nextEndDate: Date = .now

        let weight = flag.isEmpty ? 0 : flag == "+" ? 1 : -1

        if statPeriod == .week {
            nextStartDate = calendar.date(byAdding: .weekOfYear, value: weight, to: baseStartDate)!

            let weekday = calendar.component(.weekday, from: nextStartDate)

            nextStartDate = calendar.date(byAdding: .weekday, value: 1 - weekday, to: nextStartDate)!
            nextEndDate = calendar.date(byAdding: .day, value: 6, to: nextStartDate)!
        } else {
            nextStartDate = calendar.date(byAdding: .month, value: weight, to: baseStartDate)!

            let components = calendar.dateComponents([.year, .month], from: nextStartDate)

            nextStartDate = calendar.date(from: DateComponents(year: components.year, month: components.month, day: 1))!
            nextEndDate = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: nextStartDate)!
        }

        isLastWeek = nextEndDate >= .now

        baseStartDate = nextStartDate
        baseEndDate = nextEndDate
    }
}
