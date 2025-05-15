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

/// 카테고리별 회고 작성 비율을 보여주는 도넛 차트 뷰.
///
/// 사용자가 차트의 특정 섹션을 탭하면 해당 카테고리의 이름과 작성 건수를 중앙에 표시.
struct CountByCategoryChart: View {

    /// 원본 회고 데이터 배열.
    var data: [Retrospect]

    /// 차트 섹션 선택을 위한 누적 값 범위 배열.
    ///
    /// 각 카테고리별 데이터 값의 누적 범위를 저장하여 탭 위치에 따른 카테고리 식별.
    let cumulativeSalesRangesForStyle: [(category: String, range: Range<Double>)]

    /// 현재 차트에서 데이터 포인트 (카테고리 섹터).
    ///
    /// 사용자가 차트 섹션을 탭할 때 업데이트.
    @State var selectedValue: Double? = nil

    /// 현재 선택된 카테고리와 해당 카테고리의 회고 작성 건수.
    ///
    /// `selectedValue`가 변경될 때 계산.
    var selectedStyle: (category: String, count: Int)? {
        if let selectedValue,
           let selectedIndex = cumulativeSalesRangesForStyle.firstIndex(where: { $0.range.contains(selectedValue) }) {
            return chartData[selectedIndex]
        }
        return nil
    }

    /// 차트에 표시될 카테고리별 데이터. (카테고리명, 작성 건수) 튜플 배열.
    ///
    /// 원본 `data`로부터 집계 및 정렬되어 생성.
    var chartData: [(category: String, count: Int)]

    /// `CountByCategoryChart` 초기화.
    /// - Parameters:
    ///   - data: 원본 회고 데이터 배열.
    ///   - cumulativeSalesRangesForStyle: 차트 선택용 누적 범위 데이터.
    init(data: [Retrospect]) {
        self.data = data

        // 카테고리별 회고 건수 집계 및 정렬
        self.chartData = data.reduce(into: [:]) { result, data in
            result[data.category.displayName, default: 0] += 1
        }.map {
            (category: $0.key, count: $0.value)
        }.sorted { $0.category < $1.category }

        // 차트 선택용 누적 범위 계산
        var acc: Double = 0

        // 각 Sector의 범위 값을 누적해서 배열로 생성
        self.cumulativeSalesRangesForStyle = chartData.map({ (key: String, value: Int) in
            let newAcc = acc + Double(value)

            let result = (category: key, range: acc ..< newAcc)

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
        .chartLegend(.hidden)
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
