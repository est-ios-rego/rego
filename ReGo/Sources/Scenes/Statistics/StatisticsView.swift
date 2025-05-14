//
//  StatisticsView.swift
//  ReGo
//
//  Created by 성주현 on 5/12/25.
//

import Foundation
import SwiftUI
import SwiftData
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
    @Environment(\.modelContext) private var modelContext

    @State var statPeriod: StatisticsPeriodCase = .week

    let numOfWeekKr = ["첫", "둘", "셋", "넷", "다섯"]

    @State var baseStartDate: Date
    @State var baseEndDate: Date

    @State var isLastWeek: Bool = true

    @State var selectedDay: Int? = nil

//    @Query var data: [Retrospect]
    @State var data = Retrospect.detailSampleData

    @State var showEditView = false

    init(statPeriod: StatisticsPeriodCase = .week, baseStartDate: Date = .now, baseEndDate: Date = .now, isLastWeek: Bool = true) {
        self.statPeriod = statPeriod
        self.isLastWeek = isLastWeek

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
//                        Text("\(baseStartDate.toListDate) ~ \(baseEndDate.toListDate)")

                        ContributionChart(startDate: baseStartDate, endDate: baseEndDate, statPeriod: statPeriod, data: dataCountByDay, selectedDay: $selectedDay)
                            .animation(.easeOut, value: [baseStartDate, baseEndDate])

                        // 선택 기간내 회고 작성건이 없는 case
                        if dataFilteredByPeriod.isEmpty {
                            VStack {
                                Text("아직 회고를 작성하지 않으셨어요 😢")
                                    .font(.title3)
                                    .bold()
                                    .padding()

                                Text("ReGo와 나누고 싶은 소중한 이야기가 있으신가요? 작은 발견도 좋아요.")
                                    .multilineTextAlignment(.center)
                                    .font(.headline)
                                    .bold()
                                    .padding(.vertical, 32)

                                CreateButton(buttonText: "나의 이야기 남기기", showEditView: $showEditView)
                            }

                        } else {
                            if let selectedDay = selectedDay {
                                if let countByDay = dataCountByDay[selectedDay] {
                                    VStack {
                                        HStack {
                                            Text("\(selectedDay)일에는 회고를 \(String(countByDay.count))건 작성하셨어요! 🤲")
                                                .font(.title3)
                                                .bold()
                                        }
                                        .padding()

                                        MoodBarChart(moodChartData: moodChartData)
                                            .animation(.snappy, value: self.selectedDay)

                                        Text("혹시 이 날, 미처 다 적지 못했던 또 다른 기억이나 생각이 있으신가요?")
                                            .multilineTextAlignment(.center)
                                            .font(.headline)
                                            .bold()
                                            .padding(.vertical, 32)

                                        CreateButton(buttonText: "이 날의 이야기 더하기", showEditView: $showEditView)

                                    }
                                } else {
                                    VStack {
                                        Text("\(selectedDay)일에는 아직 회고를\n작성하지 않으셨어요 😢")
                                            .font(.title3)
                                            .bold()
                                            .padding()

                                        Text("ReGo와 나누고 싶은 소중한 이야기가 있으신가요? 작은 발견도 좋아요.")
                                            .multilineTextAlignment(.center)
                                            .font(.headline)
                                            .bold()
                                            .padding(.vertical, 32)

                                        CreateButton(buttonText: "나의 이야기 남기기", showEditView: $showEditView)
                                    }
                                    .padding()
                                }


                            } else {
                                let weekTotalCount = dataCountByDay.values.reduce(into: 0) {
                                    $0 += $1.count
                                }

                                HStack {
                                    Text("총 회고를 \(weekTotalCount)건 작성하셨어요 🤲")
                                        .font(.title3)
                                        .bold()

                                }
                                .padding()

                                Mood1DBarChart(moodChartData: moodChartData)
                                    .padding(.bottom)
                                    .animation(.snappy, value: [baseStartDate, baseEndDate])

                                CountByCategoryChart(startDate: baseStartDate, endDate: baseEndDate, data: dataFilteredByPeriod)
                                    .animation(.snappy, value: [baseStartDate, baseEndDate])
                            }


                        }

                        //                    if UIDevice.isPad {
                        //                        CountByCategoryChart(data: self.data)
                        //                    }
                        //                    else {
                        //                        CountByCategoryChart(data: self.data)
                        //                    }

                    }
                    .padding(.bottom)
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture {
                    selectedDay = nil
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
        }
    }
}

struct CreateButton: View {
    var buttonText: String

    @Binding var showEditView: Bool

    var body: some View {
        Button {
            showEditView = true
        } label: {
            Text(buttonText)
                .tint(.appAccent)
                .bold()
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.7))
                }
        }
        .navigationDestination(isPresented: $showEditView) {
            EditView(mode: .create)
        }
    }
}

struct iOS: PreviewProvider {
    static var previews: some View {
        StatisticsView(statPeriod: .week)
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))
    }
}

//struct iPadOSPortrait: PreviewProvider {
//    static var previews: some View {
//        StatisticsView(statPeriod: .week)
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)"))
//            .previewInterfaceOrientation(.portrait)
//    }
//}
//
//struct iPadOSLandscape: PreviewProvider {
//    static var previews: some View {
//        StatisticsView(statPeriod: .week)
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)"))
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
