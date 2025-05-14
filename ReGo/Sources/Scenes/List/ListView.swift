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

    @Query var retros: [Retrospect]

    private var filteredRetros: [Retrospect] {
        let calendar = Calendar.current

        return retros.filter { retro in
            let title = keyword.isEmpty || retro.title.lowercased().contains(keyword.lowercased())
            let category =  selectedCategory == .all || retro.category == selectedCategory

            let isSameDay = calendar.isDate(selectedStartDate, inSameDayAs: selectedEndDate)
            let date: Bool
            
            if dateSelection == "전체" {
                date = true
            } else if isSameDay {
            	date = calendar.isDate(retro.date, inSameDayAs: selectedStartDate)
			} else {
                let retroDay = calendar.startOfDay(for: retro.date)
                let startDay = calendar.startOfDay(for: selectedStartDate)
                let endDay = calendar.startOfDay(for: selectedEndDate)

                date = (startDay <= retroDay && retroDay <= endDay)
            }

            return title && category && date
        }.sorted(by: { $0.date > $1.date })
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

    @Environment(\.modelContext) private var modelContext

    @State private var keyword: String = ""
    @State private var dateSelection = "전체"
    @State private var selectedCategory: RetrospectCategory = .all
    @State private var selectedStartDate = Date.now
    @State private var selectedEndDate = Date.now

    @State private var showFilterView = false
    @State private var showCategoryPicker = false
    @State private var showEditView = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

                

                VStack {

                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("카테고리")

                            Button {
                                showCategoryPicker = true
                            } label: {
                                HStack {
                                    Text(selectedCategory.displayName)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.regoBackground2)
                                .cornerRadius(8)
                            }
                            .sheet(isPresented: $showCategoryPicker) {
                                CategoryPickerView(
                                    isPresented: $showCategoryPicker,
                                    currentCategory: $selectedCategory
                                )
                            }
                        }
                    }


                    HStack {
                        Text("날짜")

                        Spacer()

                        Picker("", selection: $dateSelection) {
                            ForEach(["전체", "기간"], id: \.self) { item in
                                Text(item)
                            }
                        }
                        .tint(.primary)
                    }

                    if dateSelection == "기간" {
                        DateFilterView(
                            selectedStartDate: $selectedStartDate,
                            selectedEndDate: $selectedEndDate
                        )
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
            .searchable(text: $keyword, prompt: "제목을 검색하세요.")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.regoAccent)
                    }
                }
            }
            .navigationDestination(isPresented: $showEditView) {
                EditView(mode: .create, retro: Retrospect.sampleData[0])
            }
        }
    }
}

struct DateFilterView: View {
    @Binding var selectedStartDate: Date
    @Binding var selectedEndDate: Date

    @State private var showStartDateSheet = false
    @State private var showEndDateSheet = false

    var body: some View {
        VStack(spacing: 8) {
            Button {
                showStartDateSheet = true
            } label: {
                HStack {
                    Text("시작일: \(selectedStartDate.toDetailDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundStyle(Color("AppAccent"))
                }
                .padding()
                .background(Color("AppBackground2"))
                .cornerRadius(8)
            }
            .onChange(of: selectedStartDate) {
                setEndDate()
            }

            Button {
                showEndDateSheet = true
            } label: {
                HStack {
                    Text("종료일: \(selectedEndDate.toDetailDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundStyle(Color("AppAccent"))
                }
                .padding()
                .background(Color("AppBackground2"))
                .cornerRadius(8)
            }
            .onChange(of: selectedEndDate) {
                setStartDate()
            }
        }
        .sheet(isPresented: $showStartDateSheet) {
            DatePickerSheet(
                isPresented: $showStartDateSheet,
                currentDate: $selectedStartDate
            )
        }
        .sheet(isPresented: $showEndDateSheet) {
            DatePickerSheet(
                isPresented: $showEndDateSheet,
                currentDate: $selectedEndDate
            )
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

#Preview {
    ListView()
        .modelContainer(for: Retrospect.self)
}

