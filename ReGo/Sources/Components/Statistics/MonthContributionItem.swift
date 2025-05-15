//
//  MonthContributionItem.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

/// 월간 기여도 차트(`ContributionChart`에서 `statPeriod`가 `.month`일 때)의 개별 날짜 셀 뷰.
///
/// 해당 날짜의 회고 작성 수에 따라 배경색 투명도가 조절.
/// 선택 시 하단에 원형 마커 표시.
struct MonthContributionItem: View {

    /// 현재 앱의 색상 스킴 (라이트/다크 모드) 환경 변수.
    @Environment(\.colorScheme) var colorScheme

    /// 기여도 수준에 따른 기본 색상. 다크/라이트 모드에 따라 다른 색상 사용.
    var color: Color {
        colorScheme == .light ? Color.regoPositive : Color.regoNegative
    }

    /// 해당 날짜의 회고 작성 건수.
    let count: Int

    /// 해당 날짜의 일(day)
    let day: Int

    /// 해당 날짜가 미래인지 여부.
    ///
    /// 미래 날짜의 경우 비활성화 처리
    let isFutureDate: Bool

    /// 현재 선택된 날짜 바인딩 변수.
    ///
    /// `day`와 일치하면 선택된 상태로 간주.
    @Binding var selectedDay: Int?

    /// 셀의 채우기 색상.
    ///
    /// `isFutureDate`가 `true`이면 회색(선택 불가), 아니면 `color`에 `count` 기반 투명도(기여도에 따른 투명도 차별화) 적용.
    var fillColor: Color {
        isFutureDate ? Color.gray.opacity(0.2) : color.opacity(0.2 * Double(count))
    }

    /// 선택 시 하단에 표시될 원형 마커의 너비. iPadOS에서 더 크게 표시.
    var circleWidth: CGFloat = UIDevice.isPad ? 8 : 5

    /// 선택 시 하단에 표시될 원형 마커의 패딩. iPadOS에서 더 크게 표시.
    var circlePadding: CGFloat = UIDevice.isPad ? 8 : 5

    var body: some View {
        Button {
            if selectedDay == day {
                selectedDay = nil // 이미 선택된 날짜 재선택 시 선택 해제
            } else {
                selectedDay = day // 새 날짜 선택
            }
        } label: {
            Rectangle()
                .fill(fillColor)
                .stroke(.black, lineWidth: 1)
                .scaledToFit()
                .overlay {
                    Text("\(day)")
                }
                .overlay(alignment: .bottom){ // 선택 시 하단 원형 마커
                    if day == selectedDay {
                        Circle()
                            .fill(Color.regoNegative)
                            .frame(width: circleWidth)
                            .scaledToFit()
                            .padding(circlePadding)
                    }
                }
        }
        .tint(.regoAccent)
        .disabled(isFutureDate) // 미래 날짜는 버튼 비활성화
    }
}
