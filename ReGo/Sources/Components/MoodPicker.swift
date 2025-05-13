//
//  MoodPicker.swift
//  ReGo
//
//  Created by 김종성 on 5/13/25.
//

import SwiftUI

struct MoodPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var currentMood: Mood

    private let moods: [Mood] = Mood.allCases
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                    ForEach(moods) { mood in
                        let isSelected = currentMood == mood

                        MoodButton(mood: mood, isSelected: isSelected) {
                            currentMood = mood
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            .navigationTitle("오늘의 기분")
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

struct MoodButton: View {
    let mood: Mood
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            Text(mood.emoji)
                .font(.largeTitle)

            Text(mood.name)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color("AppAccent").opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            onTap()
        }
    }
}
