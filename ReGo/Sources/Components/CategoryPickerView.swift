import SwiftUI

/// 사용자가 카테고리를 선택할 수 있도록 제공하는 시트형 피커 뷰
struct CategoryPickerView: View {
    /// 뷰가 표시되는지 여부를 제어하는 바인딩 값
    @Binding var isPresented: Bool
    /// 현재 선택된 카테고리
    @Binding var currentCategory: RetrospectCategory
    /// `.all` 카테고리를 포함할지 여부를 제어하는 플래그
    @State var shouldIncludeAllCategory = false

    private let categories = RetrospectCategory.allCases.filter { $0 != .all }
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories) { category in
                        let isSelected = currentCategory == category
                        CategoryButton(category: category, isSelected: isSelected) {
                            currentCategory = category
                            isPresented = false
                        }
                    }
                }
                .padding(.bottom, 7)

                if shouldIncludeAllCategory {
                    CategoryButton(category: .all, isSelected: currentCategory == .all) {
                        currentCategory = .all
                        isPresented = false
                    }
                }

            }
            .padding()
            .scrollContentBackground(.hidden)
            .background(Color.regoBackground)
            .navigationTitle("카테고리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        isPresented = false
                    }
                    .tint(Color.regoAccent)
                }
            }
            .presentationDetents([.fraction(shouldIncludeAllCategory ? 0.7 : 0.5)])
        }
    }
}

/// 개별 카테고리 버튼 UI
struct CategoryButton: View {
    let category: RetrospectCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Text(category.displayName)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundStyle(Color.regoAccent)
                .background(isSelected ? Color.regoAccent.opacity(0.2) : Color.gray.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.regoAccent : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}
