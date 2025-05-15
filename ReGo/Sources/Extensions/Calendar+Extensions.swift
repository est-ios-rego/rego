//
//  Calendar+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/14/25.
//

import Foundation

extension Calendar {

    /// 해당 월 첫날이 무슨 요일인지 반환하는 함수
    func getFirstWeekDayOfMonth(in date: Date) -> Int {
        let components = Self.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Self.current.date(from: components)!

        return Self.current.component(.weekday, from: firstDayOfMonth)
    }
}
