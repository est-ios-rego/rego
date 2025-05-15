import SwiftUI
import SwiftData

/// 개별 회고의 상세 내용을 보여주는 뷰입니다.
///
/// `Retrospect` 모델을 전달받아 회고의 카테고리, 날짜, 기분, 제목, 내용을 표시합니다.
/// 상단 툴바를 통해 회고를 수정하거나 삭제할 수 있으며,
/// 수정/삭제 시 확인 알림창이 표시됩니다.
///
/// - Parameters:
///   - retro: 상세 보기에 사용할 `Retrospect` 인스턴스
struct DetailView: View {
    /// 표시할 회고 데이터
    let retro: Retrospect

    /// 수정 화면으로 전환 여부
    @State private var showEditView = false
    /// 삭제 확인 알림 표시 여부
    @State private var showDeleteConfirm = false

    /// 토스트 메시지 출력을 위한 환경 객체
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
    /// 회고 데이터를 삭제하고 토스트 메시지를 표시합니다.
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
