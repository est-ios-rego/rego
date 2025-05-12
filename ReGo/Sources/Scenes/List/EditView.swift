//
//  EditMode.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

enum EditMode {
    case create
    case update(category: String?, title: String, content: String)
}

struct EditView: View {
    let mode: EditMode

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var currentCategory: String?
    @State private var showCategoryPicker = false

    @Environment(\.dismiss) var dismiss

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
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("현재 카테고리: \(currentCategory ?? "없음")")
                    Spacer()
                    Button("변경") {
                        showCategoryPicker = true
                    }
                }
                .sheet(isPresented: $showCategoryPicker) {
                    CategorySheet(selectedCategory: $currentCategory)
                }

                // 제목
                VStack(alignment: .leading, spacing: 8) {
                    Text("제목")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    TextField("제목을 입력해주세요.", text: $title)
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                }

                // 내용
                VStack(alignment: .leading, spacing: 8) {
                    Text("내용")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    TextEditor(text: $content)
                        .frame(minHeight: 180)
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                }

                Button(buttonTitle) {
                    // 작성/수정 내용 반영
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top)
            }
            .padding()
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if case let .update(cate, t, c) = mode {
                    currentCategory = cate
                    title = t
                    content = c
                }
            }
        }
    }
}

#Preview {
// 작성 프리뷰
//    EditView(mode: .create)

// 수정 프리뷰
    EditView(mode: .update(category: "A", title: "수정할 제목", content: "수정할 내용"))
}
