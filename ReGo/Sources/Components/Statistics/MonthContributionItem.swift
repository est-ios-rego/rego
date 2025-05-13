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

    var color: Color {
        colorScheme == .light ? Color.appPositive : Color.appNegative
    }

    var body: some View {
        Rectangle()
            .fill(color.opacity(0.2 * Double(count)))
            .stroke(.black, lineWidth: 1)
            .scaledToFit()
            .overlay {
                Text("\(day)")
            }
    }
}
