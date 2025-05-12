//
//  EditMode.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

enum EditMode {
    case create
    case update(title: String, content: String, category: String?)
}

struct EditRetroView: View {
    let mode: EditMode

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedCategory: String?
    @State private var showCategory = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("현재 카테고리: \(selectedCategory ?? "없음")")
                    Spacer()
                    Button("변경") {
                        showCategory = true
                    }
                }
                .sheet(isPresented: $showCategory) {
                    CategorySheet(selectedCategory: $selectedCategory)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("제목")
                    TextField("제목을 입력해주세요", text: $title)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("내용")
                    TextEditor(text: $content)
                        .frame(minHeight: 180)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }

                Button(modeButtonTitle) {
                    // 저장 또는 업데이트 처리
                    print("제목: \(title), 내용: \(content), 카테고리: \(selectedCategory ?? "없음")")
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
            .navigationTitle(modeNavigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if case let .update(t, c, cat) = mode {
                    title = t
                    content = c
                    selectedCategory = cat
                }
            }
        }
    }

    private var modeNavigationTitle: String {
        switch mode {
        case .create: return "작성하기"
        case .update: return "수정하기"
        }
    }

    private var modeButtonTitle: String {
        switch mode {
        case .create: return "저장하기"
        case .update: return "수정 완료"
        }
    }
}
