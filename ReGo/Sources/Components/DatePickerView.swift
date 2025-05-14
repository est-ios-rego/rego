import SwiftUI

struct DatePickerSheet: View {
    @Binding var isPresented: Bool
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
