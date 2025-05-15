//
//  WeekContributionItem.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

/// 주간 기여도 차트(`ContributionChart`에서 `statPeriod`가 `.week`일 때)의 개별 날짜 셀 뷰.
///
/// 해당 날짜의 회고 작성 수에 따라 내부 원의 투명도가 조절.
/// 선택 시 선택된 셀은 확대, 나머지 셀은 축소로 선택 셀 강조
struct WeekContributionItem: View {

    /// 현재 앱의 색상 스킴 (라이트/다크 모드) 환경 변수.
    @Environment(\.colorScheme) var colorScheme

    /// 기여도 수준에 따른 기본 색상. 다크/라이트 모드에 따라 다른 색상 사용.
    var color: Color {
        return colorScheme == .light ? Color.regoPositive : Color.regoNegative
    }

    /// 해당 날짜의 회고 작성 건수.
    let count: Int

    /// 해당 날짜의 일(day)
    let day: Int

    /// 해당 날짜가 미래인지 여부.
    ///
    /// 미래 날짜는 비활성화 처리 및 다른 스타일 적용.
    let isFutureDate: Bool

    /// 현재 선택된 날짜 바인딩 변수.
    ///
    /// `day`와 일치하면 선택된 상태로 간주.
    @Binding var selectedDay: Int?

    /// 셀의 배경 채우기 색상.
    ///
    /// `isFutureDate`가 `true`이면 회색(선택 불가), 아니면 흰색.
    var fillColor: Color {
        (isFutureDate ? Color.gray : Color.white).opacity(0.1)
    }

    var body: some View {
        Button {
            self.selectedDay = (selectedDay == day ? nil : day) // 선택 토글
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(fillColor)
                .stroke(.black, lineWidth: 1)
                .frame(height: 90)
                .overlay {
                    VStack {
                        Text("\(day)")
                            .bold()

                        Circle() // 기여도 표시 원
                            .fill(color.opacity(0.2 * Double(count))) // 작성 건수에 따른 투명도
                            .frame(width: 20)
                    }
                }
                // 선택된 날짜에 따라 스케일 효과 적용
                .scaleEffect(selectedDay == day ? 1.2 : selectedDay == nil ? 1 : 0.7)
        }
        .tint(.regoAccent)
        .disabled(isFutureDate) // 미래 날짜는 버튼 비활성화
    }
}
