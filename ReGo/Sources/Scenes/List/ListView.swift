//
//  ListView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI
import SwiftData

enum SelectedSearch {
    case title
    case category
    case date
}

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


    @State var keyword: String = ""
    @State var selectedCategory: String = ""
    @State var selectedDate = Date.now
    @State var selectedSearch: SelectedSearch = .title

    @State private var showEditView = false


    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
//                Text("회고 기록")
//                    .font(.largeTitle)
//                    .bold()
//                    .font(.title2)

                VStack(alignment: .leading) {
//                    Text("검색")
//                        .font(.title3)
//                    HStack {
//
//
//                        TextField("제목을 검색하세요", text: $keyword)
//
//                        Button {
//
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                        }
//
//
//
//                    }
//                    .padding()
//                    .background(.secondary.opacity(0.2))
//                    .clipShape(Capsule())
//                    .overlay {
//                        Capsule().stroke(Color.primary, lineWidth: 1)

//                    }


                    HStack {
                        Text("카테고리")
                        Spacer()

                        Picker("카테고리를 선택하세요", selection: $selectedCategory) {
                            ForEach(RetrospectCategory.allCases) { item in
                                Text(item.rawValue)
                            }
                        }
                        .tint(.primary)
                    }
                    HStack {
//                        Text("날짜")
//                        Spacer()

                        
                        DatePicker("날짜", selection: $selectedDate, displayedComponents: .date)

//                        DatePicker("날짜", selection: $selectedDate, displayedComponents: .datePickerStyle(.graphical)) {

                        Text("~")
                            .padding(.leading)

                        DatePicker("", selection: $selectedDate, displayedComponents: .date)

                    }
                }

                List{
                    ScrollView {
                        ForEach(dateList, id: \.self) { date in
                            Text(date)
                                .font(.title)


                            ForEach(items) { item in
                                if item.date.toYearMonth == date {
                                    NavigationLink{
                                        EmptyView()
                                    } label: {
                                        ListItem(item: item)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }

                        }

                    }
                }
                .listStyle(.plain)


            }
            .padding(.horizontal)
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            
//            .navigationTitle("회고 기록")
//            .searchable(text: $keyword, prompt: "내용을 검색하세요.")

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showEditView) {
                EditView(mode: .create)
            }
        }
    }

}

#Preview {
    ListView(items: Retrospect.sampleData)
}
