import Foundation
import SwiftUI

/// 앱의 테마 모드를 나타내는 열거형
///
/// - system: 시스템 설정을 따름
/// - light: 밝은 테마
/// - dark: 어두운 테마
enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark

    /// Identifiable 프로토콜 준수를 위한 고유 ID
    var id: String { self.rawValue }

    /// SwiftUI의 ColorScheme로 매핑되는 값
    /// 시스템 설정은 nil로 반환되어 기본 동작을 유지함
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    /// 사용자에게 보여줄 이름 (한글)
    var displayName: String {
        switch self {
        case .system: return "시스템"
        case .light: return "라이트"
        case .dark: return "다크"
        }
    }
}
