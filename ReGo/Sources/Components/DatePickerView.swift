import SwiftUI

/// 날짜를 선택할 수 있는 시트형 피커 뷰
struct DatePickerSheet: View {
    /// 뷰가 표시되는지 여부를 제어하는 바인딩 값
    @Binding var isPresented: Bool
    /// 현재 선택된 날짜
    @Binding var currentDate: Date

    var body: some View {
        NavigationStack {
            ScrollView {
                DatePicker("", selection: $currentDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .onChange(of: currentDate) {
                    isPresented = false
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("AppBackground"))
            .navigationTitle("날짜")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        isPresented = false
                    }
                    .tint(Color("AppAccent"))
                }
            }
            .presentationDetents([.fraction(0.75)])
        }
    }
}
