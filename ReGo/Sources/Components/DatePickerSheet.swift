//
//  DatePickerSheet.swift
//  ReGo
//
//  Created by 김종성 on 5/14/25.
//

import SwiftUI

struct DatePickerSheet: View {
    @Environment(\.dismiss) var dismiss
	@Binding var currentDate: Date

    var body: some View {
        NavigationStack {
            ScrollView {
                DatePicker("", selection: $currentDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
            }
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            .navigationTitle("날짜")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                    .tint(Color("AppAccent"))
                }
            }
            .presentationDetents([.fraction(0.75)])
        }
    }
}
