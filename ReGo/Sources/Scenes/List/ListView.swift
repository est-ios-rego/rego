//
//  ListView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI
import SwiftData

enum DateFilter {
    case all
    case filterd

}

struct ListView: View {
    //    @Query(sort: [SortDescriptor(\Retrospect.id, order: .forward)])

    var retros: [Retrospect]

    private var filteredRetros: [Retrospect] {
        retros.filter { retro in
            let title = keyword.isEmpty || retro.title.lowercased().contains(keyword.lowercased())
            let category =  selectedCategory == "" || retro.category.rawValue == selectedCategory
            let date = dateSelection == "전체" || selectedStartDate <= retro.date && retro.date  <= selectedEndDate

            return title && category && date
        }

    }

    private var dateList: [String] {
        var setDate: Set<String> = []
        var arrayDate: [String] = []

        filteredRetros.forEach {
            setDate.insert($0.date.toYearMonth)
        }

        setDate.forEach {
            arrayDate.append($0)
        }

        return arrayDate.sorted().reversed()
    }


    @State var keyword: String = ""
    @State var selectedCategory: String = ""
    @State var selectedStartDate = Date.now
    @State var selectedEndDate = Date.now

    @State private var showEditView = false
    @State private var dateSelection = "전체"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack {

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
                        Text("날짜")

                        Spacer()

                        Picker("", selection: $dateSelection) {
                            ForEach(["전체", "선택하기"], id: \.self) { item in
                                Text(item)
                            }
                        }
                        .tint(.primary)
                    }

                    if dateSelection == "선택하기" {
                        HStack  {
                            DatePicker("", selection: $selectedStartDate, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "ko_kr"))
                                .labelsHidden()
                                .padding(.trailing, 15)



                            //            DatePicker("날짜", selection: $selectedDate, displayedComponents: .datePickerStyle(.graphical)) {

                            Spacer()

                            Text("~")

                            Spacer()


                            DatePicker("", selection: $selectedEndDate, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "ko_kr"))
                                .labelsHidden()
                                .padding(.trailing, 15)


                        }
                        .onChange(of: selectedStartDate) {
                            setEndDate()
                        }
                        .onChange(of: selectedEndDate) {
                            setStartDate()
                        }
                    }

                }


                ScrollView {
                    ForEach(dateList, id: \.self) { date in
                        VStack(alignment: .leading) {
                            Text(date)
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            VStack(spacing: 15){

                                ForEach(filteredRetros) { item in
                                    if item.date.toYearMonth == date {
                                        NavigationLink{
                                            DetailView(retro: item)
                                        } label: {
                                            ListItem(item: item)

                                        }
                                    }
                                }
                            }.background(Color.regoBackground2)
                        }
                        .padding(.bottom, 20)
                    }

                }


                .listStyle(.plain)



            }
            .padding(.horizontal)
            .scrollContentBackground(.hidden)
            .background(Color.regoBackground)

            .navigationTitle("회고 기록")
            .searchable(text: $keyword, prompt: "내용을 검색하세요.")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("AppAccent"))
                    }
                }
            }
            .navigationDestination(isPresented: $showEditView) {
                EditView(mode: .create)
            }
        }
    }
    func setEndDate() {
        switch selectedStartDate.compare(selectedEndDate) {
        case .orderedDescending:
            selectedEndDate = selectedStartDate
        default:
            break
        }
    }

    func setStartDate() {
        switch selectedEndDate.compare(selectedStartDate) {
        case .orderedAscending:
            selectedStartDate = selectedEndDate
        default:
            break
        }
    }
}


//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Retrospect.self, configurations: config)
//
//
//    ListView(items: Retrospect.sampleData)
//        .modelContainer(container)
//}

#Preview {
    ListView(retros: Retrospect.sampleData)
}
