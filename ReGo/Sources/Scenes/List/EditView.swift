//
//  EditMode.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

enum EditMode {
    case create
    case update
}

struct EditView: View {
    let mode: EditMode

    @Bindable var retro: Retrospect

    @State private var originalTitle: String = ""
    @State private var originalContent: String = ""
    @State private var originalDate: Date = Date()
    @State private var originalCategory: RetrospectCategory = .daily
    @State private var originalMood: Mood = .neutral

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()
    @State private var category: RetrospectCategory = .daily
    @State private var mood: Mood = .neutral

    @State private var showCategoryPicker = false
    @State private var showDatePicker = false
    @State private var showMoodPicker = false
    @State private var showDismissAlert = false
    @State private var showTitleAlert = false

    @FocusState private var isTitleFocused: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private var navigationTitle: String {
        switch mode {
        case .create: return "생성하기"
        case .update: return "수정하기"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TitleSection(title: $title, isTitleFocused: $isTitleFocused)

                ContentSection(content: $content)

                CategorySection(category: $category, showCategoryPicker: $showCategoryPicker)

                DateSection(date: $date, showDatePicker: $showDatePicker)

                MoodSection(mood: $mood, showMoodPicker: $showMoodPicker)
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(Color("AppBackground"))
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if isDataChanged {
                        showDismissAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color("AppAccent"))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("저장") {
                    print("date: \(date), retro.date: \(retro.date)")
                    onClickSave()
                }
                .foregroundStyle(Color("AppAccent"))
            }
        }
        .onAppear {
            switch mode {
            case .create:
                isTitleFocused = true
            case .update:
                initRetro()
            }
        }
        .alert("변경사항이 저장되지 않았습니다.\n나가시겠습니까?", isPresented: $showDismissAlert) {
            Button("취소", role: .cancel) {}

            Button("나가기", role: .destructive) {
                dismiss()
            }
        }
        .alert("제목을 입력해주세요.", isPresented: $showTitleAlert) {
            Button("확인") {
                isTitleFocused = true
            }
        }
    }
}

extension EditView {

    private var isDataChanged: Bool {
        let calendar = Calendar.current
        let isSameDay = calendar.isDate(originalDate, inSameDayAs: date)

        return title != originalTitle ||
               content != originalContent ||
               category != originalCategory ||
               !isSameDay ||
               mood != originalMood
    }

    private func initRetro() {
        originalTitle = retro.title
        originalContent = retro.content
        originalCategory = retro.category
        originalDate = retro.date
        originalMood = retro.mood

        title = retro.title
        content = retro.content
        category = retro.category
        date = retro.date
        mood = retro.mood
    }

    private func onClickSave() {
        guard validateInput() else { return }

        switch mode {
        case .create:
            createRetrospect()
        case .update:
            updateRetrospect()
        }

        dismiss()
    }

    private func validateInput() -> Bool {
        if title.isEmpty {
            showTitleAlert = true
            return false
        }
        return true
    }

    private func createRetrospect() {
        let newRetro = Retrospect(
            title: title,
            content: content,
            date: date,
            category: category,
            mood: mood
        )
        modelContext.insert(newRetro)
        saveData()
    }

    private func updateRetrospect() {
        retro.title = title
        retro.content = content
        retro.date = date
        retro.category = category
        retro.date = date
        retro.mood = mood
        saveData()
    }

    private func saveData() {
        try? modelContext.save()
    }
}

struct TitleSection: View {
    @Binding var title: String
    @FocusState.Binding var isTitleFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("제목")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("제목을 입력해주세요.", text: $title)
                .padding(12)
                .background(Color("AppBackground2"))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .focused($isTitleFocused)
        }
    }
}

struct ContentSection: View {
    @Binding var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("내용")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextEditor(text: $content)
                .padding(12)
                .frame(minHeight: 200, maxHeight: 400)
                .background(Color("AppBackground2"))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
        }
    }
}

struct CategorySection: View {
    @Binding var category: RetrospectCategory
    @Binding var showCategoryPicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("카테고리")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button {
                showCategoryPicker = true
            } label: {
                HStack {
                    Text("\(category.displayName)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("AppBackground2"))
                .cornerRadius(8)
            }
            .sheet(isPresented: $showCategoryPicker) {
                CategoryPicker(currentCategory: $category, isEditMode: true)
            }
        }
    }
}

struct DateSection: View {
    @Binding var date: Date
    @Binding var showDatePicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("날짜")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button {
                showDatePicker = true
            } label: {
                HStack {
                    Text("\(date.toDetailDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("AppBackground2"))
                .cornerRadius(8)
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(currentDate: $date)
            }
        }
    }
}

struct MoodSection: View {
    @Binding var mood: Mood
    @Binding var showMoodPicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("오늘의 기분")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button {
                showMoodPicker = true
            } label: {
                HStack {
                    Text("\(mood.emoji) \(mood.name)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("AppBackground2"))
                .cornerRadius(8)
            }
            .sheet(isPresented: $showMoodPicker) {
                MoodPicker(currentMood: $mood)
            }
        }
    }
}

#Preview {
    let sampleRetro = Retrospect(
        title: "수정할 제목",
        content: "수정할 내용입니다.",
        date: Date(),
        category: .daily,
        mood: .happy
    )

    NavigationStack {
        // 작성 프리뷰
//      EditView(mode: .create)

        // 수정 프리뷰
        EditView(mode: .update, retro: sampleRetro)
    }
}
