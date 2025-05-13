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

    private let numOfWeekKr = ["첫", "둘", "셋", "넷", "다섯"]

    @State var baseStartDate: Date
    @State var baseEndDate: Date

    @State var isLastWeek: Bool = true

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

    var data = Retrospect.sampleDataForStatistics

    init(statPeriod: StatisticsPeriodCase = .week, baseStartDate: Date = .now, baseEndDate: Date = .now, isLastWeek: Bool = true, data: [Retrospect] = Retrospect.sampleDataForStatistics) {
        self.statPeriod = statPeriod

        self.isLastWeek = isLastWeek
        self.data = data

        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_Kr")
        calendar.timeZone = TimeZone(abbreviation: "KST")!

        let weekday = calendar.component(.weekday, from: .now)

        self.baseStartDate = calendar.date(byAdding: .weekday, value: 1 - weekday, to: .now)!
        self.baseEndDate = calendar.date(byAdding: .weekday, value: 7 - weekday, to: .now)!
    }

    func moveDate(_ flag: String) {
        let calendar = Calendar.current

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

    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $statPeriod) {
                    Text("주")
                        .tag(StatisticsPeriodCase.week)

                    Text("월")
                        .tag(StatisticsPeriodCase.month)
                } label: {

                }
                .pickerStyle(.palette)
                .onChange(of: statPeriod) {
                    moveDate("")
                }

                HStack {
                    Button {
                        moveDate("-")
                    } label: {
                        Image(systemName: "chevron.left")
                    }

                    Spacer()

                    if statPeriod == .week {
                        Text("\(baseStartDate.toYearMonth) \(weekOfMonth)째 주")
                    } else {
                        Text(baseStartDate.toYearMonth)
                    }

                    Spacer()

                    Button {
                        moveDate("+")
                    } label: {
                        Image(systemName: "chevron.right")
                    }.disabled(isLastWeek)

                }
                .padding()

                ScrollView {
                    VStack {
                        Text("\(baseStartDate.toListDate) ~ \(baseEndDate.toListDate)")

                        if data.isEmpty {
                            Text("아직 작성한 회고가 없어요.. ㅠ")

                            Button {

                            } label: {
                                Text("회고 작성하러 가기")
                            }
                        } else {
                            ContributionChart(startDate: baseStartDate, endDate: baseEndDate, statPeriod: statPeriod, data: data)
                                .padding(.vertical)
                                .padding(.horizontal, 4)

                            CountByCategoryChart(startDate: $baseStartDate, endDate: $baseEndDate, data: data)
                        }

                        //                    if UIDevice.isPad {
                        //                        CountByCategoryChart(data: self.data)
                        //                    }
                        //                    else {
                        //                        CountByCategoryChart(data: self.data)
                        //                    }

                    }
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.inline)
            }
            .scrollContentBackground(.hidden)
            .padding()
            .background(Color("AppBackground"))
        }
    }
}

struct ContributionChart: View {
    var startDate: Date
    var endDate: Date

    var statPeriod: StatisticsPeriodCase

    @State var data: [Retrospect]

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
            .filter {
                return $0.date >= startDate && $0.date <= endDate
            }
            .reduce(into: [:]) { result, item in
                let day = calendar.component(.day, from: item.date)

                result[day, default: 0] += 1
            }
    }

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)

    struct WeekContributionItem: View {
        let count: Int
        let day: Int

        var body: some View {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .stroke(.black, lineWidth: 1)
                .frame(height: 90)
                .overlay {
                    VStack {
                        //                        Text("일")
                        //                            .font(.subheadline)
                        //                            .foregroundStyle(.gray)
                        //                            .bold()

                        Text("\(day)")
                            .bold()

                        Circle()
                            .fill(.green.opacity(0.2 * Double(count)))
                            .frame(width: 20)

                    }

                }
        }

    }

    struct MonthContributionItem: View {
        let count: Int
        let day: Int

        var body: some View {
            Rectangle()
                .fill(.green.opacity(0.2 * Double(count)))
                .stroke(.black, lineWidth: 1)
                .scaledToFit()
                .overlay {
                    Text("\(day)")
                }
        }
    }

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(dayArray, id: \.self) { day in
                let count = filteredData[day] ?? 0

                if statPeriod == .week {
                    WeekContributionItem(count: count, day: day)
                } else {
                    MonthContributionItem(count: count, day: day)
                }

            }
        }

        //        HStack(spacing: 0) {
        //            ForEach(dayArray, id: \.self) { day in
        //                let count = filteredData[day] ?? 0
        //
        //                VStack {
        //                    Rectangle()
        //                        .fill(.green.opacity(0.2 * Double(count)))
        //                        .stroke(.black, lineWidth: 1)
        //                        .scaledToFit()
        //                        .overlay {
        //                            Text("\(day)")
        //                        }
        //                }
        //
        //            }
        //        }
        //        .padding()
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
