//
//  WeekContributionItem.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

struct WeekContributionItem: View {
    @Environment(\.colorScheme) var colorScheme

    var color: Color {
        return colorScheme == .light ? Color.appPositive : Color.appNegative
    }

    let count: Int
    let day: Int

    let isFutureDate: Bool

    var fillColor: Color {
        (isFutureDate ? Color.gray : Color.white).opacity(0.1)
    }

    @Binding var selectedDay: Int?

    var body: some View {
        Button {
            self.selectedDay = (selectedDay == day ? nil : day)
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(fillColor)
                .stroke(.black, lineWidth: 1)
                .frame(height: 90)
                .overlay {
                    VStack {
                        Text("\(day)")
                            .bold()

                        Circle()
                            .fill(color.opacity(0.2 * Double(count)))
                            .frame(width: 20)
                    }

                }
                .scaleEffect(selectedDay == day ? 1.2 : selectedDay == nil ? 1 : 0.7)
        }
        .tint(.appAccent)
        .disabled(isFutureDate)

    }
}
