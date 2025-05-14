//
//  EditMode.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

enum EditMode {
    case create
    case update(retro: Retrospect)
}

struct EditView: View {
    let mode: EditMode

    @State private var originalTitle: String = ""
    @State private var originalContent: String = ""
    @State private var originalDate: Date = Date()
    @State private var originalCategory: RetrospectCategory = .category1
    @State private var originalMood: Mood = .neutral

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()
    @State private var category: RetrospectCategory = .category1
    @State private var mood: Mood = .neutral

    @State private var showCategoryPicker = false
    @State private var showMoodPicker = false
    @State private var showDismissAlert = false
    @State private var showTitleAlert = false

    @FocusState private var isTitleFocused: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private var navigationTitle: String {
        switch mode {
        case .create: return "작성하기"
        case .update: return "수정하기"
        }
    }

    private var buttonTitle: String {
        switch mode {
        case .create: return "작성하기"
        case .update: return "수정하기"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 제목
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

            // 내용
            VStack(alignment: .leading, spacing: 8) {
                Text("내용")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                TextEditor(text: $content)
                    .padding(12)
                    .frame(minHeight: 200)
                    .background(Color("AppBackground2"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
            }

            // 날짜
            VStack(alignment: .leading, spacing: 8) {
                Text("카테고리")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button {

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
            }

            // 카테고리
            VStack(alignment: .leading, spacing: 8) {
                Text("카테고리")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button {
                    showCategoryPicker = true
                } label: {
                    HStack {
                        Text("\(category.rawValue)")
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

            // 오늘의 기분
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
        .padding()
        .scrollContentBackground(.hidden)
        .background(Color("AppBackground"))
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
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
                    onClickSave()
                }
                .foregroundStyle(Color("AppAccent"))
            }
        }
        .onAppear {
            switch mode {
            case .create:
                isTitleFocused = true
            case .update(let retro):
                initRetro(retro)
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
        // TODO: 날짜 비교 추가 (연월일만)
        return title != originalTitle ||
               content != originalContent ||
               category != originalCategory ||
               mood != originalMood
    }

    private func initRetro(_ retro: Retrospect) {
        originalTitle = retro.title
        originalContent = retro.content
        originalCategory = retro.category
        originalMood = retro.mood

        title = retro.title
        content = retro.content
        category = retro.category
        mood = retro.mood
    }

    private func onClickSave() {
        guard validateInput() else { return }

        switch mode {
        case .create:
            createRetrospect()
        case .update(let retro):
            updateRetrospect(retro)
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
            date: Date(),
            category: category,
            mood: mood
        )
        modelContext.insert(newRetro)
    }

    private func updateRetrospect(_ retro: Retrospect) {
        retro.title = title
        retro.content = content
        retro.category = category
    }
}

#Preview {
    let sampleRetro = Retrospect(
        title: "수정할 제목",
        content: "수정할 내용입니다.",
        date: Date(),
        category: .category3,
        mood: .happy
    )

    NavigationStack {
        // 작성 프리뷰
      EditView(mode: .create)

        // 수정 프리뷰
//        EditView(mode: .update(retro: sampleRetro))
    }
}
