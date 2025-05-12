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

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()
    @State private var category: RetrospectCategory = .category1

    @State private var showCategoryPicker = false

    @Environment(\.dismiss) private var dismiss

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
            HStack {
                Text("현재 카테고리: \(category.rawValue)")
                Spacer()
                Button("변경") {
                    showCategoryPicker = true
                }
            }
            .sheet(isPresented: $showCategoryPicker) {
                CategoryPicker(currentCategory: $category)
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .onAppear {
            if case let .update(retro) = mode {
                title = retro.title
                content = retro.content
                date = retro.date
                category = retro.category
            }
        }
    }
}

#Preview {
    let sampleRetro = Retrospect(
        title: "수정할 제목",
        content: "수정할 내용입니다.",
        date: Date(),
        category: .category3
    )

    NavigationStack {
        // 작성 프리뷰
        //    EditView(mode: .create)

        // 수정 프리뷰
        EditView(
            mode: .update(retro: sampleRetro)
        )
    }
}
