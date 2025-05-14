import Foundation
import SwiftData

/// 회고의 카테고리를 나타내는 열거형
///
/// 사용자가 회고를 분류할 때 선택할 수 있는 범주를 정의합니다.
/// `.all`은 필터링에만 사용되며 저장에는 사용되지 않습니다.
enum RetrospectCategory: String, Codable, CaseIterable, Identifiable {
    case daily
    case work
    case study
    case relationship
    case goal
    case lesson
    case all

    /// Identifiable 프로토콜 준수를 위한 고유 ID
    var id: String { rawValue }

    /// 사용자에게 보여질 한글 표시 이름
    var displayName: String {
        switch self {
        case .daily: return "일상"
        case .work: return "업무"
        case .study: return "학습"
        case .relationship: return "관계"
        case .goal: return "목표"
        case .lesson: return "교훈"
        case .all: return "전체"
        }
    }
}

/// 회고 작성 시 선택 가능한 감정 상태를 나타내는 열거형
enum Mood: String, CaseIterable, Identifiable, Codable, Equatable {
    case happy, sad, angry, tired, excited, neutral, anxious

    /// Identifiable 프로토콜 준수를 위한 고유 ID
    var id: String { rawValue }

    /// 감정 이름 (한글)
    var name: String {
        switch self {
        case .happy: return "행복"
        case .sad: return "슬픔"
        case .angry: return "분노"
        case .tired: return "지침"
        case .excited: return "설렘"
        case .neutral: return "무덤덤"
        case .anxious: return "불안"
        }
    }

    /// 감정에 해당하는 이모지
    var emoji: String {
        switch self {
        case .happy: return "😀"
        case .sad: return "😢"
        case .angry: return "😠"
        case .tired: return "😩"
        case .excited: return "🥰"
        case .neutral: return "😐"
        case .anxious: return "😰"
        }
    }
}

/// SwiftData에 저장되는 회고(Retrospect) 모델 클래스
///
/// 사용자가 기록하는 회고의 제목, 내용, 날짜, 카테고리, 감정을 저장합니다.
@Model
class Retrospect {
    /// 회고 제목
    var title: String
    /// 회고 본문 내용
    var content: String
    /// 회고 날짜
    var date: Date
    /// 회고의 카테고리
    var category: RetrospectCategory
    /// 회고 작성 당시의 기분
    var mood: Mood

    /// 회고 모델 초기화 메서드
    /// - Parameters:
    ///   - title: 제목
    ///   - content: 본문 내용
    ///   - date: 작성 날짜
    ///   - category: 카테고리
    ///   - mood: 기분
    init(title: String, content: String, date: Date, category: RetrospectCategory, mood: Mood) {
        self.title = title
        self.content = content
        self.date = date
        self.category = category
        self.mood = mood
    }
}
