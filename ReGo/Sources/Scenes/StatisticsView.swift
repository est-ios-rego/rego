//
//  StatisticsView.swift
//  ReGo
//
//  Created by 성주현 on 5/12/25.
//
/// 사용자 회고 통계를 다양한 방식으로 시각화하여 보여주는 뷰.
///
/// 주간/월간 기여도, 감정 분포, 카테고리별 비율 등 다각적인 통계 정보를 제공.
//

import Foundation
import SwiftUI
import SwiftData
import Charts

/// 통계 조회 기간 단위 열거형.
enum StatisticsPeriodCase {
    /// 주간 단위.
    case week
    /// 월간 단위.
    case month
}

/// 감정 통계 차트 표시용 데이터 구조체.
struct MoodChartItem {
    /// id
    var id: UUID = UUID()
    /// 감정 표현 이모지
    var emoji: String
    /// 해당 감정 회고 개수
    var count: Int
    /// 차트 표시 색상
    var color: Color
}

/// 사용자 회고 통계를 시각적으로 제공하는 메인 뷰.
///
/// 이 뷰는 사용자의 회고 데이터를 기반으로 주간 또는 월간 단위의 통계를 생성하고,
/// Contribution 차트, 감정 분포 차트, 카테고리별 차트 등을 통해 다양한 관점에서
/// 회고 패턴을 분석할 수 있도록 지원.
struct StatisticsView: View {
    /// SwiftData 모델 컨텍스트 환경 변수.
    @Environment(\.modelContext) private var modelContext

    /// 현재 선택된 통계 기간 (주간/월간) 상태 변수.
    @State var statPeriod: StatisticsPeriodCase = .week

    /// 시작 날짜 상태 변수.
    @State var baseStartDate: Date
    /// 종료 날짜 상태 변수.
    @State var baseEndDate: Date

    /// 현재 조회 기간의 마지막 주/월 여부 상태 변수.
    @State var isLastWeek: Bool = true

    /// Contribution Chart에서 선택된 날짜(일) 상태 변수.
    @State var selectedDay: Int? = nil

    var selectedDate: Date? {
        guard let selectedDay = selectedDay else {
            return nil
        }

        let components = Calendar.current.dateComponents([.year, .month], from: baseStartDate)

        return Calendar.current.date(from: DateComponents(year: components.year, month: components.month, day: selectedDay)) ?? nil
    }

    /// SwiftData를 통해 저장된 회고 객체 불러와서 바인딩
    let retros: [Retrospect]

    /// 회고 등록 화면 표시 여부 상태 변수.
    @State var showEditView = false

    /// 뷰 내 애니메이션 효과 상태 변수.
    @State var isAnimated: Bool = false

    /// 주차를 한글로 표시하기 위한 배열 (예: "첫째 주", "둘째 주").
    let numOfWeekKr = ["첫", "둘", "셋", "넷", "다섯"]

    init(retros: [Retrospect]) {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: .now)

        // 단위 기간의 시작일 기본 값은 일요일 0시 0분 0초
        var startDate = calendar.date(byAdding: .weekday, value: 1 - weekday, to: .now)!

        // 단위 기간의 시작일 기본 값은 토요일 0시 0분 0초
        startDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)!

        // 기본값을 현재 날짜가 속한 주의 시작일과 종료일로 설정.
        self.baseStartDate = startDate
        self.baseEndDate = calendar.date(byAdding: .weekday, value: 6, to: startDate)!
        self.retros = retros
    }

    /// 통계 화면 헤더 뷰.
    ///
    /// 기간 선택 피커(주/월) 및 날짜 이동 버튼 포함.
    var statisticsHeader: some View {
        VStack {
            Picker(selection: $statPeriod) {
                Text("주")
                    .tag(StatisticsPeriodCase.week)

                Text("월")
                    .tag(StatisticsPeriodCase.month)
            } label: { }
            .pickerStyle(.palette)
            .onChange(of: statPeriod) {
                changePeriodCase($1)
            }

            HStack {
                Button {
                    changeDate(isNext: false)
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
                    changeDate(isNext: true)
                } label: {
                    Image(systemName: "chevron.right")
                }.disabled(isLastWeek)
            }
            .padding()
        }
        .frame(width: UIDevice.isPad ? 500 : nil) // iPad 헤더 너비 제한.
    }

    /// 데이터가 없을 시 표시 뷰.
    var noDataView: some View {
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
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    statisticsHeader

                    VStack {
                        ContributionChart(startDate: baseStartDate, endDate: baseEndDate, statPeriod: statPeriod, data: dataCountByDay, selectedDay: $selectedDay)
                            .frame(maxWidth: UIDevice.isPad ? 500 : .infinity) // iPad 차트 너비 제한.


                            // 선택 기간 내 회고 작성 건 없는 경우
                            if dataFilteredByPeriod.isEmpty {
                                noDataView
                            } else {

                                // Contribution Chart (잔디밭) 날짜 선택 시
                                if let selectedDay = selectedDay {

                                        // 선택 날짜에 회고 작성 건 있는 경우
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
//                                            .animation(.smooth, value: isAnimated)
//                                            .onAppear {
//                                                isAnimated = true
//                                            }
//                                            .onDisappear() {
//                                                isAnimated = false
//                                            }
                                        } else {
                                            // 선택 날짜에 회고 작성 건 없는 경우
                                            noDataView
                                        }

                                } else {
                                    // 날짜 미선택 (기간 전체 통계)
                                    let weekTotalCount = dataCountByDay.values.reduce(into: 0) {
                                        $0 += $1.count
                                    }

                                    HStack {
                                        Text("총 회고를 \(weekTotalCount)건 작성하셨어요 🤲")
                                            .font(.title3)
                                            .bold()
                                            .padding()

//                                         Text("ReGo와 나누고 싶은 소중한 이야기가 있으신가요? 작은 발견도 좋아요.")
//                                             .multilineTextAlignment(.center)
//                                             .font(.headline)
//                                             .bold()
//                                             .padding(.vertical, 32)
//
//                                         CreateButton(buttonText: "나의 이야기 남기기", showEditView: $showEditView)
                                    }
                                    .padding()

                                    if UIDevice.isPad { // iPad 레이아웃
                                        HStack() {
                                            MoodBarChart(moodChartData: moodChartData)
                                                .animation(.snappy, value: self.selectedDay)
                                                .padding()
                                                .frame(maxWidth: .infinity)


                                            Spacer()

                                            CountByCategoryChart(data: dataFilteredByPeriod)
                                                .animation(.easeInOut, value: [baseStartDate, baseEndDate])
                                                .frame(maxWidth: .infinity)

                                        }
                                    } else { // iPhone 레이아웃
                                        Mood1DBarChart(moodChartData: moodChartData)
                                            .padding(.bottom)
                                            .animation(.easeInOut, value: [baseStartDate, baseEndDate])

                                        CountByCategoryChart(data: dataFilteredByPeriod)
                                            .animation(.easeInOut, value: [baseStartDate, baseEndDate])
                                    }
                                }
                            }
                    }
                    .padding(.bottom)
                    .navigationDestination(isPresented: $showEditView) {
                        EditView(mode: .create, retro: Retrospect(
                            title: "",
                            content: "",
                            date: selectedDate ?? .now,
                            category: .daily,
                            mood: .tired
                        ))
                    }
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.inline)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .background(Color.regoBackground)
        }
    }
}


// MARK: - SwiftUI Previews

struct iOS: PreviewProvider {
    static var previews: some View {
        StatisticsView(retros: Retrospect.detailSampleData)
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro")) // 최신 기기 또는 일반 기기명 사용 권장.
    }
}

/// iPad 세로 모드 미리보기용 구조체.
//struct iPadOSPortrait: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)")) // 최신 기기 또는 일반 기기명 사용 권장.
//            .previewInterfaceOrientation(.portrait)
//    }
//}

/// iPad 가로 모드 미리보기용 구조체.
//struct iPadOSLandscape: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro 11-inch (M4)")) // 최신 기기 또는 일반 기기명 사용 권장.
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
