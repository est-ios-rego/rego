//
//  MoodBarChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/14/25.
//

import SwiftUI
import Charts

struct MoodBarChart: View {
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
                .annotation(content: {
                    Text(item.emoji)
                })
                .foregroundStyle(item.color)
                // TODO: 프리뷰 고장나서 임시 주석
//                .annotation(position: .overlay) {
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.gray.opacity(0.5))
//                        .padding(-4)
//                }
            }
        }
        .scaledToFit()
        .frame(maxHeight: 200)
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
    }
}

