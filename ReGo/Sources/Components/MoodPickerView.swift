import SwiftUI

/// 사용자가 기분(Mood)을 선택할 수 있는 시트형 피커 뷰
struct MoodPickerView: View {
    /// 뷰가 표시되는지 여부를 제어하는 바인딩 값
    @Binding var isPresented: Bool
    /// 현재 선택된 기분
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
                            isPresented = false
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
                        isPresented = false
                    }
                    .tint(Color("AppAccent"))
                }
            }
            .presentationDetents([.fraction(0.5)])
        }
    }
}

/// 개별 기분을 선택할 수 있는 버튼
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
