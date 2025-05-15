//
//  StatisticsView+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation

/// `StatisticsView`의 확장.
///
/// 통계 계산 및 데이터 필터링 관련 로직 포함.
extension StatisticsView {
    /// 현재 설정된 기간(`baseStartDate` ~ `baseEndDate`)으로 필터링된 회고 데이터 배열.
    var dataFilteredByPeriod: [Retrospect] {
        return self.data.filter {
            return $0.date >= self.baseStartDate && $0.date <= self.baseEndDate
        }
    }

    /// 선택된 날짜(`selectedDay`)로 필터링된 회고 데이터 배열.
    ///
    /// `selectedDay`가 `nil`이 아닐 경우, 해당 '일'에 작성된 회고만 필터링.
    var dataFilteredByDay: [Retrospect] {
        let calendar = Calendar.current

        return data.filter {
            // 포함 조건: 회고 날짜의 '일' 요소가 selectedDay와 동일.
            selectedDay == calendar.component(.day, from: $0.date)
        }
    }

    /// 현재 필터링된 기간 내 각 '일'별 회고 작성 건수 및 해당 날짜 Dictionary.
    ///
    /// Key: 날짜의 '일'(Int).
    /// Value: (날짜: Date, 작성 건수: Int) Tuple.
    var dataCountByDay: [Int: (date: Date, count: Int)] {
        let calendar: Calendar = Calendar.current

        // dataFilteredByPeriod (현재 기간으로 필터링된 데이터)를 사용.
        return dataFilteredByPeriod
            .reduce(into: [:]) { result, item in
                let day = calendar.component(.day, from: item.date)

                result[day, default: (date: item.date, count: 0)].count += 1
            }
    }

    /// 감정 분포 차트(`MoodBarChart`, `Mood1DBarChart`)용 데이터 배열.
    ///
    /// `selectedDay`가 있으면 해당 날짜의 감정 분포, 없으면 현재 기간 전체의 Mood 분포 계산.
    var moodChartData: [MoodChartItem] {
        var moodChartItems = [MoodChartItem]()

        // selectedDay 유무에 따라 필터링 대상 데이터 결정.
        let targetData = selectedDay == nil ? dataFilteredByPeriod : dataFilteredByDay

        // 감정별 회고 건수 집계.
        let countDict = targetData.reduce(into: [:]) {
            $0[$1.mood, default: 0] += 1
        }

        // 집계된 데이터를 MoodChartItem 배열로 변환.
        for item in countDict {
            moodChartItems.append(MoodChartItem(emoji: item.key.emoji, count: item.value, color: item.key.color))
        }

        return moodChartItems
    }

    /// 현재 `baseStartDate`가 속한 달의 몇 번째 주인지 한글 문자열.
    ///
    /// 예: "첫", "둘", "셋". `numOfWeekKr` 배열 사용.
    var weekOfMonth: String {
        let calendar = Calendar.current

        let year = calendar.component(.year, from: baseStartDate)
        let month = calendar.component(.month, from: baseStartDate)
        let day = calendar.component(.day, from: baseStartDate)

        // 해당 월의 1일.
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1, hour: 9))!

        // 해당 월의 첫 번째 목요일의 '일'.
        let firstThursday = (5 - (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7) % 7 + 1

        // 첫 목요일로부터 현재 '일'까지의 차이.
        let daysSinceFirstThursday = day - firstThursday

        // 주차 계산.
        let weekNumber = (daysSinceFirstThursday / 7) + 1

        return numOfWeekKr[weekNumber - 1]
    }

    /// 주간 통계에서 `ContributionChart`에 표시될 날짜(일) 범위.
    ///
    /// `baseStartDate`의 '일'부터 `baseEndDate`의 '일'까지.
    var weekdayRange: Range<Int> {
        Calendar.current.component(.day, from: baseStartDate) ..< Calendar.current.component(.day, from: baseEndDate) + 1
    }

    /// 통계 조회 기간 단위를 변경하는 메서드 (주간/월간).
    ///
    /// `baseStartDate`와 `baseEndDate`를 새로운 기간 단위에 맞게 재설정.
    /// `selectedDay`는 `nil`로 초기화.
    /// - Parameter newValue: 새로운 통계 기간 단위 (`.week` 또는 `.month`).
    func changePeriodCase(_ newValue: StatisticsPeriodCase) {
        let calendar = Calendar.current

        // 기간 단위가 바뀌면서 선택한 '일'을 초기화
        defer {
            selectedDay = nil
        }

        var nextStartDate: Date = .now
        var nextEndDate: Date = .now

        let components = calendar.dateComponents([.year, .month], from: baseStartDate)

        // 현재 baseStartDate가 속한 달의 1일로 시작일 설정.
        nextStartDate = calendar.date(from: DateComponents(year: components.year, month: components.month, weekday: 1))!

        if newValue == .week {
            // 주간 단위: 현재 월의 첫 번째 주의 시작일과 종료일로 설정.
            let firstWeekdayOfMonth = calendar.component(.weekday, from: nextStartDate)
            nextStartDate = calendar.date(byAdding: .day, value: 8 - firstWeekdayOfMonth, to: nextStartDate)!
            nextEndDate = calendar.date(byAdding: .day, value: 6, to: nextStartDate)!
        }
        else {
            // 월간 단위: 해당 월의 1일부터 마지막 날까지로 설정.
            nextEndDate = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: nextStartDate)!
        }

        // isLastWeek 상태 업데이트: 새로운 종료 날짜가 현재 시점 이후인지 확인.
        isLastWeek = nextEndDate >= .now

        baseStartDate = nextStartDate
        baseEndDate = nextEndDate
    }

    /// 통계 조회 날짜를 이전/다음 기간으로 변경하는 메서드.
    ///
    /// `statPeriod` (주간/월간)에 따라 `baseStartDate`와 `baseEndDate`를 조정.
    /// `selectedDay`는 `nil`로 초기화.
    /// - Parameter isNext: 다음 기간으로 이동할지 여부 (`true`면 다음, `false`면 이전).
    func changeDate(isNext: Bool) {
        let calendar = Calendar.current

        // 기간이 바뀌면서 선택한 '일'을 초기화
        defer {
            selectedDay = nil
        }

        var nextStartDate: Date = .now
        var nextEndDate: Date = .now

        if statPeriod == .week {
            // 주간 단위: 현재 baseStartDate에서 일주일 전/후로 이동.
            nextStartDate = calendar.date(byAdding: .weekOfYear, value: isNext ? 1 : -1, to: baseStartDate)!

            let weekday = calendar.component(.weekday, from: nextStartDate)

            // 이동한 주의 시작일(일요일)과 종료일(토요일)을 계산
            nextStartDate = calendar.date(byAdding: .weekday, value: 1 - weekday, to: nextStartDate)!
            nextEndDate = calendar.date(byAdding: .day, value: 6, to: nextStartDate)!
        } else {
            // 월간 단위: 현재 baseStartDate에서 한 달 전/후로 이동.
            nextStartDate = calendar.date(byAdding: .month, value: isNext ? 1 : -1, to: baseStartDate)!

            let components = calendar.dateComponents([.year, .month], from: nextStartDate)

            // 이동된 달의 1일과 마지막 날 계산.
            nextStartDate = calendar.date(from: DateComponents(year: components.year, month: components.month, day: 1))!
            nextEndDate = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: nextStartDate)!
        }

        // isLastWeek 상태 업데이트: 새로운 종료 날짜가 현재 시점 이후인지 확인.
        isLastWeek = nextEndDate >= .now

        baseStartDate = nextStartDate
        baseEndDate = nextEndDate
    }
}
