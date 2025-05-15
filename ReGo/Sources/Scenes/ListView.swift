//
//  ListView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI
import SwiftData

/// 날짜 메뉴를 나타내는 열거형
enum DateMenuOption: String, CaseIterable {
    case all = "전체"
    case filtered = "기간"
}

/// 회고 목록을 가져오는 뷰
struct ListView: View {
    /// SwiftData와 연결된 객체
    let retros: [Retrospect]

    /// SwiftData 객체를 Filtering한 속성
    private var filteredRetros: [Retrospect] {
        let calendar = Calendar.current

        return retros.filter { retro in
            let title = keyword.isEmpty || retro.title.lowercased().contains(keyword.lowercased())
            let category =  selectedCategory == .all || retro.category == selectedCategory

            let isSameDay = calendar.isDate(selectedStartDate, inSameDayAs: selectedEndDate)
            let date: Bool

            if selectedDateMenu == .all {
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

    /// 목록을 불러올 때 년-월로 묶어주는 속성
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


    /// Filtering할 값
    @State private var keyword: String = ""
    @State private var selectedDateMenu: DateMenuOption = .all
    @State private var selectedCategory: RetrospectCategory = .all
    @State private var selectedStartDate = Date.now
    @State private var selectedEndDate = Date.now

    /// Filtering 시 불러올 피커와 시트 제어
    @State private var showFilterView = false
    @State private var showCategoryPicker = false
    @State private var showEditView = false
    @State private var showDatePicker = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

                VStack {
                    CategoryView(showCategoryPicker: $showCategoryPicker, selectedCategory: $selectedCategory)

                    DateView(selectedDateMenu: $selectedDateMenu, selectedStartDate: $selectedStartDate, selectedEndDate: $selectedEndDate, showDatePicker: $showDatePicker)

                }

                /// filteredRetros을 불러오는 ScrollView
                ScrollView {
                    ForEach(dateList, id: \.self) { date in
                        VStack(alignment: .leading) {
                            Text(date)
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            VStack {
                                ForEach(filteredRetros) { item in
                                    if item.date.toYearMonth == date {
                                        VStack {
                                            NavigationLink {
                                                DetailView(retro: item)
                                            } label: {
                                                ListItem(item: item)
                                            }

                                            Divider()
                                                .padding(.horizontal, 16)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                            .background(Color.regoBackground2)
                            .cornerRadius(8)
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
                EditView(mode: .create, retro: Retrospect.emptyData)
            }
        }
    }
}

// MARK: - Filtering하는 Sheet와 Picker를 불러오는 UI
/// Category
struct CategoryView: View {
    /// CategoryPicker 표시여부  바인딩
    @Binding var showCategoryPicker: Bool
    /// 선택된 Category 바인딩
    @Binding var selectedCategory: RetrospectCategory

    var body: some View {
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
                    currentCategory: $selectedCategory,
                    shouldIncludeAllCategory: true
                )
            }
        }
    }
}

/// DateMenu
struct DateView: View {
    /// 전체를 보여줄지 일부 날짜를 보여줄지 선택하는 열거형 바인딩
    @Binding var selectedDateMenu: DateMenuOption
    /// Filtering 시작 날짜 바인딩
    @Binding var selectedStartDate: Date
    /// Filtering 끝나는  날짜 바인딩
    @Binding var selectedEndDate: Date
    /// DatePicker 표시 여부 바인딩
    @Binding var showDatePicker: Bool

    var body: some View {
        VStack{
            HStack {
                Text("날짜")

                Spacer()

                if selectedDateMenu == .filtered {
                    HStack {
                        Text(selectedStartDate.toListDate)
                            .labelsHidden()

                        Text("~")

                        Text(selectedEndDate.toListDate)
                            .labelsHidden()
                    }
                }

                Menu {
                    Button("전체") {
                        selectedDateMenu = .all
                    }

                    Button("기간") {
                        selectedDateMenu = .filtered
                        showDatePicker = true
                    }
                } label: {
                    HStack(spacing: 2) {
                        Text(selectedDateMenu.rawValue)

                        Image(systemName: "chevron.right")
                    }
                    .tint(.regoAccent)
                }
            }

            if selectedDateMenu == .filtered {
                if showDatePicker{
                    DateFilterView(
                        selectedStartDate: $selectedStartDate,
                        selectedEndDate: $selectedEndDate,
                        showDatePicker: $showDatePicker
                    )
                }
            }
        }

    }
}

/// DatePicker
struct DateFilterView: View {
    /// Filtering 시작 날짜 바인딩
    @Binding var selectedStartDate: Date
    /// Filtering 끝나는  날짜 바인딩
    @Binding var selectedEndDate: Date
    /// DatePicker 표시 여부 바인딩
    @Binding var showDatePicker: Bool

    /// DateSheet에 시작날짜
    @State private var showStartDateSheet = false
    /// DateSheet에 끝나는 날짜
    @State private var showEndDateSheet = false

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            Button {
                showStartDateSheet = true
            } label: {
                HStack {
                    Text("\(selectedStartDate.toListDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.regoAccent)
                }
                .padding()
                .background(Color.regoBackground2)
                .cornerRadius(8)
            }
            .onChange(of: selectedStartDate) {
                setEndDate()
            }

            Button {
                showEndDateSheet = true
            } label: {
                HStack {
                    Text("\(selectedEndDate.toListDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.regoAccent)
                }
                .padding()
                .background(Color.regoBackground2)
                .cornerRadius(8)
            }
            .onChange(of: selectedEndDate) {
                setStartDate()
            }

            Button {
                showDatePicker = false
            } label: {
                Text("완료")
                    .foregroundStyle(Color.regoAccent)
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
    /// 시작 날짜를 끝나는 날짜보다 미래를 선택하면 끝나는 날짜를 시작 날짜와 같아지는 기능을 지원합니다.
    func setEndDate() {
        switch selectedStartDate.compare(selectedEndDate) {
        case .orderedDescending:
            selectedEndDate = selectedStartDate
        default:
            break
        }
    }
    /// 끝나는 날짜가  시작 날짜보다 과거를 선택하면 시작 날짜를 끝나는 날짜와 같아지는 기능을 지원합니다.
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
    ListView(retros: Retrospect.sampleData)
}


