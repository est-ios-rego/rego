//
//  ListItem.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI


struct ListItem: View {
    var item: Retrospect

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(item.category.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.regoCategoryBg)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(item.title)
                    .tint(.primary)

                Spacer()

                Text(item.mood.emoji)
                    .padding(.trailing, 10)

            }

            Text(item.date.toListDate)
                .tint(.secondary)
        }
    }
}


