//
//  DetailView.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

struct DetailView: View {
    let retro: Retrospect

    @State private var showEditView = false
    @State private var showDeleteConfirm = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // 카테고리
                HStack {
                    Text("카테고리")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(retro.category.rawValue)
                        .fontWeight(.medium)
                }

                Divider()

                // 제목
                VStack(alignment: .leading, spacing: 8) {
                    Text("제목")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(retro.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }

                // 내용
                VStack(alignment: .leading, spacing: 8) {
                    Text("내용")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(retro.content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }

                Spacer()
            }
            .padding()
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color("AppAccent"))
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(Color("AppAccent"))
                    }
                    .buttonStyle(.borderless)

                    Spacer()

                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(Color("AppNegative"))
                    }
                    .buttonStyle(.borderless)
                }
            }
            .navigationDestination(isPresented: $showEditView) {
                EditView(mode: .update(retro: retro))
            }
            .alert("삭제하시겠습니까?", isPresented: $showDeleteConfirm) {
                Button("취소", role: .cancel) {}

                Button("삭제", role: .destructive) {
                    delete()
                }
            }
        }
    }
}

extension DetailView {
    func delete() {
        // TODO: 삭제 로직 구현
    }
}

#Preview {
	let sampleRetro = Retrospect(
        title: "회고 제목 샘플",
        content: """
        회고 작성 중입니다.
        여러 줄의 텍스트
        """,
        date: Date(),
        category: .category2
    )

    NavigationStack {
        DetailView(retro: sampleRetro)
    }
}
