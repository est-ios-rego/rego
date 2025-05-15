import SwiftUI

/// 사용자에게 간단한 피드백 메시지를 잠시 표시하는 전역 토스트 관리 클래스입니다.
///
/// `@EnvironmentObject`로 주입받아, 어떤 View에서도 토스트 메시지를 띄울 수 있습니다.
///
/// ```swift
/// toastManager.show(message: "저장되었습니다!")
/// ```
final class ToastManager: ObservableObject {
    /// 현재 토스트 표시 여부
    @Published var isPresented = false

    /// 표시할 메시지
    @Published var message = ""

    /// 토스트를 표시하고 일정 시간 후 자동으로 사라지게 합니다.
    ///
    /// - Parameters:
    ///   - message: 사용자에게 표시할 메시지
    ///   - duration: 표시될 지속 시간 (기본값: 2초)
    func show(message: String, duration: TimeInterval = 2) {
        self.isPresented = true
        self.message = message

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isPresented = false
        }
    }
}
