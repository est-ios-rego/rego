//
//  Mood1DChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/14/25.
//

import SwiftUI
import Charts

/// Mood별 회고 작성 비율을 막대 차트(수평)로 시각화하는 뷰.
///
/// 각 Mood의 비율만큼 막대가 채워지며, 해당 감정 이모지가 막대 위에 표시.
struct Mood1DBarChart: View {

    /// 차트에 표시될 Mood 데이터 배열.
    ///
    /// 각 요소는 `MoodChartItem`으로, 감정 이모지, 작성 건수, 색상 정보 포함.
    var moodChartData: [MoodChartItem]

    var body: some View {
        Chart(moodChartData, id: \.id) { (item: MoodChartItem) in
            BarMark(
                x: .value("Count", item.count)
            )
            .foregroundStyle(item.color) // 지정해둔 Mood별 색상으로 막대를 시각화
            .annotation(position: .overlay) {
                Text(item.emoji) // Emoji를 막대 내부에 표시
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .chartXAxis(.hidden)
        .chartLegend(.hidden)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.3), lineWidth: 1)
        }
        .padding(.horizontal, 8)
    }
}
