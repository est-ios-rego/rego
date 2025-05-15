//
//  DetailView.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let retro: Retrospect

    @State private var showEditView = false
    @State private var showDeleteConfirm = false

    @EnvironmentObject private var toastManager: ToastManager

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 카테고리
                    HStack {
                        Text("카테고리")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(retro.category.displayName)
                            .fontWeight(.medium)
                    }

                    // 날짜
                    HStack {
                        Text("날짜")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(retro.date.toDetailDate)
                            .font(.subheadline)
                    }

                    // 기분
                    HStack(spacing: 8) {
                        Text("기분")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("\(retro.mood.emoji) \(retro.mood.name)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
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
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(Color.regoBackground)
        .navigationTitle("상세보기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.regoAccent)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    HStack {
                        Button {
                            showEditView = true
                        } label: {
                            Label("수정", systemImage: "square.and.pencil")
                        }
                    }

                    HStack {
                        Button(role: .destructive) {
                            showDeleteConfirm = true
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(Color.regoAccent)
                }
            }
        }
        .navigationDestination(isPresented: $showEditView) {
            EditView(mode: .update, retro: retro)
        }
        .alert("삭제하시겠습니까?", isPresented: $showDeleteConfirm) {
            Button("취소", role: .cancel) {}

            Button("삭제", role: .destructive) {
                deleteRetrospect()
                dismiss()
            }
        }
    }
}

extension DetailView {
    private func deleteRetrospect() {
        modelContext.delete(retro)
        toastManager.show(message: "삭제되었습니다.")
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
        category: .daily,
        mood: .happy
    )

    NavigationStack {
        DetailView(retro: sampleRetro)
    }
}
