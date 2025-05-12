//
//  CategorySheet.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

struct CategoryPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var currentCategory: RetrospectCategory

    let categories = RetrospectCategory.allCases
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories) { category in
                        CategoryButton(
                            category: category,
                            isSelected: currentCategory == category
                        ) {
                            currentCategory = category
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("카테고리 선택")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CategoryButton: View {
    let category: RetrospectCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        let backgroundColor = isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1)
        let borderColor = isSelected ? Color.blue : Color.gray.opacity(0.3)

        Button {
            onTap()
        } label: {
            Text(category.rawValue)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(backgroundColor)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
    }
}
