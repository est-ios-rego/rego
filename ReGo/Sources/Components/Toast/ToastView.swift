import SwiftUI

/// 간단한 텍스트 메시지를 하단에 표시하는 Toast 스타일의 뷰입니다.
///
/// 일반적으로 `ToastModifier` 내부에서 사용됩니다.
struct ToastView: View {
    /// 토스트에 표시할 메시지
    let message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundColor(.primary)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    ZStack {
        TabView {
            Color.regoBackground
                .ignoresSafeArea()
                .tabItem {
                    Label("홈", systemImage: "house")
                }
        }

        VStack {
            Spacer()
            ToastView(message: "토스트 메시지입니다.")
                .padding(.bottom, 70)
        }
    }
}
