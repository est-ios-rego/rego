//
//  MoodBarChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/14/25.
//

import SwiftUI
import Charts

/// Mood별 회고 작성 비율을 막대 차트(수직)로 시각화하는 뷰.
///
/// 각 막대는 Mood를 나타내며, 막대의 높이는 해당 Mood로 작성된 회고의 수에 비례.
/// 해당 감정 이모지가 막대 상단에 표시.
struct MoodBarChart: View {

    /// 차트에 표시될 Mood 데이터 배열.
    ///
    /// 각 요소는 `MoodChartItem`으로, 감정 이모지, 작성 건수, 색상 정보 포함.
    var moodChartData: [MoodChartItem]

    var body: some View {
        Chart {
            ForEach(moodChartData, id: \.id) { (item: MoodChartItem) in
                BarMark(
                    x: .value("Mood", item.emoji),
                    y: .value("Count", Int(item.count)),
                    width: 25
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(item.color) // 지정해둔 Mood별 색상으로 막대를 시각화
                .annotation(content: {
                    Text(item.emoji) // Emoji를 막대 상단에 표시
                })
                // FIXME: 프리뷰 고장으로 임시 주석 처리
//                .annotation(position: .overlay) {
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.gray.opacity(0.5))
//                        .padding(-4)
//                }
            }
        }
        .scaledToFit()
        .frame(maxHeight: 200)
        .chartYAxis(.hidden) // Y축 숨김
        .chartXAxis(.hidden) // X축 숨김
    }
}
