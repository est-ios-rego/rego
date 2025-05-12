//
//  ListItem.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI


struct ListItem: View {
    var item: Restrospect

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(item.date, style: .date)
                .font(.title2)

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
            .frame(maxWidth: .infinity)

            .background(.blue)
        }


    }
}

#Preview {
    ListItem(item: Restrospect.sampleData[0])
        .environment(\.locale, Locale(identifier: "ko_kr"))
}
