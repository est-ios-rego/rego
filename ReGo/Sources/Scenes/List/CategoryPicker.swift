//
//  CategorySheet.swift
//  ReGo
//
//  Created by 김종성 on 5/12/25.
//

import SwiftUI

struct CategorySheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: String?

    let categories = ["A", "B", "C", "D", "E", "F", "G", "H"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                            dismiss()
                        } label: {
                            Text(category)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(
                                    selectedCategory == category ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1)
                                )
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                                )
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
