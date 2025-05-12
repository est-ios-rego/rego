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

        VStack(alignment: .leading) {
            HStack {
                Text(item.category.rawValue)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(item.title)
            }

            Text(item.date.toListDate)
        }
    }
}

#Preview {
    ListItem(item: Retrospect.sampleData[0])
        .environment(\.locale, Locale(identifier: "ko_kr"))
}
