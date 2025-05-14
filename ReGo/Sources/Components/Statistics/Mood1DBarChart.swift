//
//  Mood1DChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/14/25.
//

import SwiftUI
import Charts

struct Mood1DBarChart: View {
    var moodChartData: [MoodChartItem]

    var body: some View {
        Chart(moodChartData, id: \.id) { (item: MoodChartItem) in
            BarMark(
                x: .value("Count", item.count)
            )
            .foregroundStyle(item.color)
            .annotation(position: .overlay) {
                Text(item.emoji)
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
