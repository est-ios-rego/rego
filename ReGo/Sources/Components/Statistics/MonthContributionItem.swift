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

    var body: some View {
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
                        .frame(width: 5)
                        .scaledToFit()
                        .padding(5)
                }
            }
            .onTapGesture {
                if isFutureDate {
                    return
                }

                if selectedDay == day {
                    selectedDay = nil
                } else {
                    selectedDay = day
                }
            }
    }
}
