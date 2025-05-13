//
//  StatisticsView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import Foundation
import SwiftUI
import Charts

enum StatisticsPeriodCase {
	case week
    case month
}

struct StatisticsView: View {
    @State var statPeriod: StatisticsPeriodCase = .week

    var calendar: Calendar = Calendar.current

    private let numOfWeekKr = ["첫", "둘", "셋", "넷", "다섯"]

    @State var baseStartDate: Date = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "KST")!

        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        let day = calendar.component(.day, from: .now)

        print(Calendar.current.date(from: DateComponents(year: year, month: month, day: day, weekday: 1)))
        print(calendar.date(from: DateComponents(year: year, month: month, day: day, weekday: 1)))
        return calendar.date(from: DateComponents(year: year, month: month, day: day, weekday: 1))!
    } ()

    @State var baseEndDate: Date = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "KST")!

        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        let day = calendar.component(.day, from: .now)

        print("-------------------")
        print(Calendar.current.date(from: DateComponents(year: year, month: month, day: day, weekday: 6)))
        print(calendar.date(from: DateComponents(year: year, month: month, day: day, weekday: 6)))
        print("-------------------")
        

        return calendar.date(from: DateComponents(year: year, month: month, day: day, weekday: 6))!
    }()

    @State var isLastWeek: Bool = true

    var year: String {
        return String(calendar.component(.year, from: self.baseStartDate))
    }

    var month: String {
        return String(calendar.component(.month, from: self.baseStartDate))
    }

    var weekOfMonth: String {
        let year = calendar.component(.year, from: baseStartDate)
        let month = calendar.component(.month, from: baseStartDate)
        let day = calendar.component(.day, from: baseStartDate)

        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1, hour: 9))!

        let firstThursday = (5 - (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7) % 7 + 1

        let daysSinceFirstThursday = day - firstThursday

        let weekNumber = (daysSinceFirstThursday / 7) + 1

		return numOfWeekKr[weekNumber - 1]
    }

    var data = Retrospect.sampleData

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker(selection: $statPeriod) {
						Text("주")
                            .tag(StatisticsPeriodCase.week)

                        Text("월")
                            .tag(StatisticsPeriodCase.month)
                    } label: {
                    }
                    .pickerStyle(.palette)

                    Text(baseStartDate, format: .dateTime)
                    Text(baseEndDate, format: .dateTime)

                    HStack {
                        Button {
                            let nextStartDate = calendar.date(byAdding: .weekOfYear, value: -1, to: baseStartDate)!
                            let nextEndDate = Calendar.current.date(byAdding: .day, value: 6, to: nextStartDate)!

                            isLastWeek = nextEndDate < .now

                            baseStartDate = nextStartDate
                            baseEndDate = nextEndDate
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                        Spacer()

                        Text("\(year)년 \(month)월 \(weekOfMonth)째 주")

                        Spacer()

                        Button {
                            let nextStartDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: baseStartDate)!
                            let nextEndDate = Calendar.current.date(byAdding: .day, value: 6, to: nextStartDate)!

                            isLastWeek = nextEndDate >= .now

                            baseStartDate = nextStartDate
                            baseEndDate = nextEndDate
                        } label: {
                            Image(systemName: "chevron.right")
                        }

                    }
                    .padding()

                    CountByCategoryChart(startDate: $baseStartDate, endDate: $baseEndDate, data: data)

//                    if UIDevice.isPad {
//                        CountByCategoryChart(data: self.data)
//                    }
//                    else {
//                        CountByCategoryChart(data: self.data)
//                    }
                    
                }
                .padding()
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CountByCategoryChart: View {
    @Binding var startDate: Date
    @Binding var endDate: Date

    @State var data: [Retrospect]

    var chartData: [String: Int] {
        data.filter {
            return $0.date >= startDate && $0.date <= endDate
        }.reduce(into: [:]) { result, data in
            result[data.category.rawValue, default: 0] += 1
        }
    }

    var body: some View {
        Chart {
            ForEach(chartData.sorted(by: <), id: \.key) { category, count in
                SectorMark(angle: .value("Category", count),
                           innerRadius: .ratio(0.618),
                           angularInset: 1.5)
                .foregroundStyle(by: .value("Category", category))
            }
        }
        .scaledToFit()
        .chartLegend(position: UIDevice.isPad ? .trailing : .bottom, alignment: UIDevice.isPad ? .center : .bottom, spacing: 16)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let chartFrame = chartProxy.plotFrame {
                    let frame = geometry[chartFrame]

                    Text("카테고리별 통계")
                        .position(x: frame.midX, y: frame.midY)
                }
            }

        }
    }

}

struct iOS: PreviewProvider {
    static var previews: some View {
        StatisticsView(statPeriod: .week)
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))
    }
}

struct iPadOSPortrait: PreviewProvider {
    static var previews: some View {
        StatisticsView(statPeriod: .week)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)"))
            .previewInterfaceOrientation(.portrait)
    }
}

struct iPadOSLandscape: PreviewProvider {
    static var previews: some View {
        StatisticsView(statPeriod: .week)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
