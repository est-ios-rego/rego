//
//  CategoryPicker.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

struct CategoryPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var currentCategory: RetrospectCategory

    private let categories = RetrospectCategory.allCases
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories) { category in
                        let isSelected = currentCategory == category

                        CategoryButton(category: category, isSelected: isSelected) {
                            currentCategory = category
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            .navigationTitle("카테고리 선택")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                    .tint(Color("AppAccent"))
                }
            }
            .presentationDetents([.fraction(0.5)])
        }
    }
}

struct CategoryButton: View {
    let category: RetrospectCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Text(category.rawValue)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundStyle(Color("AppAccent"))
                .background(isSelected ? Color("AppAccent").opacity(0.2) : Color.gray.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color("AppAccent") : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}
