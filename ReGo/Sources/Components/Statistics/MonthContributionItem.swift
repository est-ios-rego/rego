//
//  MonthContributionItem.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

struct MonthContributionItem: View {
    @Environment(\.colorScheme) var colorScheme

    let count: Int
    let day: Int

    let isFutureDate: Bool

    @Binding var selectedDay: Int?

    var color: Color {
        colorScheme == .light ? Color.appPositive : Color.appNegative
    }

    var fillColor: Color {
        isFutureDate ? Color.gray.opacity(0.2) : color.opacity(0.2 * Double(count))
    }

    var circleWidth: CGFloat = UIDevice.isPad ? 8 : 5

    var circlePadding: CGFloat = UIDevice.isPad ? 8 : 5

    var body: some View {
        Button {
            if selectedDay == day {
                selectedDay = nil
            } else {
                selectedDay = day
            }
        } label: {
            Rectangle()
                .fill(fillColor)
                .stroke(.black, lineWidth: 1)
                .scaledToFit()
                .overlay {
                    Text("\(day)")
                }
                .overlay(alignment: .bottom){
                    if day == selectedDay {
                        Circle()
                            .fill(Color.appNegative)
                            .frame(width: circleWidth)
                            .scaledToFit()
                            .padding(circlePadding)
                    }
                }
        }
        .tint(.appAccent)
        .disabled(isFutureDate)

    }
}
