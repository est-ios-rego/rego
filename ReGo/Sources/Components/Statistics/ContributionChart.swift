//
//  ContributionChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//


import Foundation
import SwiftUI
import SwiftData

/// 회고 기여도(잔디밭) 차트 표시를 위한 데이터 아이템 구조체.
///
/// `ContributionChart` 내에서 각 날짜별 기여도 표시용.
struct ContributionChartItem: Hashable, Identifiable {
    /// 고유 식별자.
    var id: UUID = UUID()
    /// 해당 날짜의 일 (day)
    var day: Int
    /// 해당 날짜.
    var date: Date
}

/// 회고 기여도(잔디밭)를 시각화하는 뷰.
///
/// 주간 또는 월간 단위로 각 날짜의 회고 작성 현황을 격자 형태로 표시.
/// 사용자는 각 날짜 셀을 탭하여 상세 정보를 확인 가능.
struct ContributionChart: View {
    /// 데이터 시작 기준 날짜.
    var startDate: Date

    /// 데이터 종료 기준 날짜.
    var endDate: Date

    /// 통계 기간 단위 (`week` 또는 `month`).
    ///
    /// 이 값에 따라 `WeekContributionItem` 또는 `MonthContributionItem`을 렌더링
    var statPeriod: StatisticsPeriodCase

    /// 날짜별 회고 작성 수 데이터.
    ///
    /// Key는 날짜의 '일'(Int), Value는 (날짜, 개수) 튜플.
    var data: [Int: (date: Date, count: Int)]

    /// 현재 선택된 날짜의 '일' 바인딩 변수.
    ///
    /// `nil`이면 아무 날짜도 선택되지 않은 상태.
    @Binding var selectedDay: Int?

    /// 주어진 기간 내의 모든 날짜에 대한 `ContributionChartItem` 배열.
    ///
    /// `startDate`부터 `endDate`까지 각 날짜 별로 `ContributionChartItem`을 생성
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

            interval = 86400 // 하루 간격 (초)
            count += 1
        } while count <= Int(endDate.timeIntervalSince(startDate) / 86400)

        return result
    }

    /// 요일 헤더 표시 뷰 (Sun, Mon, Tue...)
    var weekdayHeader: some View {
        ForEach(0 ..< 7) { weekday in
            Text(Calendar.current.shortWeekdaySymbols[weekday])
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
    }

    /// 월간 차트에서 첫 주 시작 요일 앞의 빈 공간 채우기용 뷰.
    var emptyItem: some View {
        let firstWeekday = Calendar.current.getFirstWeekDayOfMonth(in: startDate)

        return ForEach(0 ..< firstWeekday - 1, id: \.self) { _ in
            Spacer()
        }
    }

    /// 각 날짜별 기여도 아이템 표시 뷰
    ///
    /// `statPeriod` 값에 따라 `WeekContributionItem` 또는 `MonthContributionItem`을 렌더링
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
