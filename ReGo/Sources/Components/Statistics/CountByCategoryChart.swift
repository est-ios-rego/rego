//
//  CountByCategoryChart.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData
import Charts

struct CountByCategoryChart: View {
    var startDate: Date
    var endDate: Date

    var data: [Retrospect]

    let cumulativeSalesRangesForStyle: [(category: String, range: Range<Double>)]

    @State var selectedValue: Double? = nil

    var selectedStyle: (category: String, count: Int)? {
        if let selectedValue, let selectedIndex = cumulativeSalesRangesForStyle.firstIndex(where: { $0.range.contains(selectedValue) }) {
            return chartData[selectedIndex]
        }

        return nil
    }

    var chartData: [(category: String, count: Int)]

    init(startDate: Date, endDate: Date, data: [Retrospect], cumulativeSalesRangesForStyle: [(category: String, range: Range<Double>)]? = nil) {
        self.startDate = startDate
        self.endDate = endDate
        self.data = data

        self.chartData = data.reduce(into: [:]) { result, data in
            result[data.category.displayName, default: 0] += 1
        }.map {
            (category: $0.key, count: $0.value)
        }.sorted(by: { $0.category < $1.category })

        var acc: Double = 0

        self.cumulativeSalesRangesForStyle = chartData.map({ (key: String, value: Int) in
            let newAcc = acc + Double(value)
            let result = (category: key, range: acc..<newAcc)

            acc = newAcc

            return result
        })
    }

    var body: some View {
        Chart {
            ForEach(chartData, id: \.category) { category, count in
                let isSelected = category == selectedStyle?.category

                SectorMark(angle: .value("Category", count),
                           innerRadius: .ratio(isSelected ? 0.518 : 0.618),
                           angularInset: 1.5)
                .opacity(isSelected ? 1 : 0.3)
                .foregroundStyle(by: .value("Category", category))
            }
        }
        .scaledToFit()
        .chartLegend(position: UIDevice.isPad ? .trailing : .bottom, alignment: UIDevice.isPad ? .center : .bottom, spacing: 16)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let chartFrame = chartProxy.plotFrame {
                    let frame = geometry[chartFrame]

                    VStack {
                        if let selected = selectedStyle {
                            Text(selected.category)
                                .font(.title3)
                                .padding(.bottom)

                            Text("\(selected.count)건")
                                .font(.callout)

                        } else {
                            Text("어떤 카테고리들로\n작성했을까요?\n눌러서 확인해 보세요!")
                                .multilineTextAlignment(.center)

                        }
                    }
                    .position(x: frame.midX, y: frame.midY)


                }
            }
        }
        .chartAngleSelection(value: $selectedValue)
        .animation(.easeInOut, value: selectedValue)
    }

}
