import SwiftUI

/// ToastView를 현재 뷰의 하단에 오버레이하는 뷰 모디파이어입니다.
///
/// 내부적으로 `ZStack`을 사용해 토스트를 조건부로 표시합니다.
struct ToastModifier: ViewModifier {
    /// 토스트 표시 여부 (Binding)
    @Binding var isPresented: Bool

    /// 토스트에 표시할 메시지
    let message: String

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message)
                        .padding(.bottom, 70)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}
