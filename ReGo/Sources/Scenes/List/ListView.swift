//
//  ListView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    var items: [Retrospect]
    var dateList: [String] {
        var setDate: Set<String> = []
        var arrayDate: [String] = []

        items.forEach {
            setDate.insert($0.date.toYearMonth)
        }

        setDate.forEach {
            arrayDate.append($0)
        }

        return arrayDate.sorted()
    }

    var body: some View {

        NavigationStack {
            VStack(alignment: .leading) {
                Text("List")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .font(.title2)

                ScrollView {
                    ForEach(dateList, id: \.self) { date in
                        Text(date)
                            .font(.largeTitle)
                        List {
                            ForEach(items) { item in
                                if item.date.toYearMonth == date {
                                    NavigationLink{
                                        TestView()
                                    } label: {
                                        ListItem(item: item)
                                    }
                                }
                            }
                        }
                    }

                }


            }
            .padding(.horizontal)

        }
    }

}

#Preview {
    ListView(items: Retrospect.sampleData)
}
