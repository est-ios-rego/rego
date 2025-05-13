//
//  StatisticsView.swift
//  ReGo
//
//  Created by 성주현 on 5/12/25.
//

import Foundation
import SwiftUI
import Charts

enum StatisticsPeriodCase {
    case week
    case month
}

struct MoodChartItem {
    var id: UUID = UUID()
    var emoji: String
    var count: Int
    var color: Color
}

struct StatisticsView: View {
    @State var statPeriod: StatisticsPeriodCase = .week

    let numOfWeekKr = ["첫", "둘", "셋", "넷", "다섯"]

    @State var baseStartDate: Date
    @State var baseEndDate: Date

    @State var isLastWeek: Bool = true

    @State var selectedDay: Int? = nil

    @State var data = Retrospect.detailSampleData

    init(statPeriod: StatisticsPeriodCase = .week, baseStartDate: Date = .now, baseEndDate: Date = .now, isLastWeek: Bool = true, data: [Retrospect] = Retrospect.detailSampleData) {
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
                    selectedDay = nil
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

                        if dataFilteredByPeriod.isEmpty {
                            VStack {
                                Spacer()

                                Text("이번주엔 아직 회고를 작성하지 않으셨어요 😢")
                                    .font(.title3)
                                    .bold()

                                Button {

                                } label: {
                                    Text("회고 작성하러 가기")
                                }

                                Spacer()
                            }

                        } else {
                            ContributionChart(startDate: baseStartDate, endDate: baseEndDate, statPeriod: statPeriod, data: dataFilteredByPeriod, selectedDay: $selectedDay)

                            if let selectedDay = selectedDay {
                                if let countByDay = dataCountByDay[selectedDay] {
                                    VStack {
                                        Button("test") {
                                            print(moodChartData)
                                        }

                                        HStack {
                                            Text("\(selectedDay)일에는 회고를 총 \(String(countByDay))회 작성하셨어요! 🤲")
                                                .font(.title3)
                                                .bold()
                                        }
                                        .padding()

                                        Chart {
                                            ForEach(moodChartData, id: \.id) { (item: MoodChartItem) in
                                                BarMark(
                                                    x: .value("Mood", item.emoji),
                                                    y: .value("Count", Int(item.count)),
                                                    width: 50
                                                )
                                                .cornerRadius(16)
                                                .annotation(content: {
                                                    Text(item.emoji)
                                                })
                                                .foregroundStyle(item.color)
                                            }
                                        }
                                        .chartYAxis(.hidden)
                                        .chartXAxis(.hidden)

                                    }
                                } else {
                                    HStack {
                                        Text("\(selectedDay)일에는 아직 회고를 작성하지 않으셨어요 😢")
                                            .font(.title3)
                                            .bold()

                                    }
                                    .padding()
                                }


                            } else {
                                let weekTotalCount = dataCountByDay.values.reduce(into: 0) {
                                    $0 += $1
                                }

                                HStack {
                                    Text("총 \(weekTotalCount)회 회고를 작성하셨어요 🤲")
                                        .font(.title3)
                                        .bold()

                                }
                                .padding()

                                CountByCategoryChart(startDate: baseStartDate, endDate: baseEndDate, data: dataFilteredByPeriod)
                                    .animation(.easeInOut, value: selectedDay)
                            }


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
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedDay = nil
                    }
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
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
