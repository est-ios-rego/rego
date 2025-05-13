//
//  Retrospect.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import Foundation
import SwiftData

enum RetrospectCategory: String, Codable, CaseIterable, Identifiable {
	case category1
    case category2
    case category3
    case category4
    case category5
    case category6 = ""

    var id: String { rawValue }
}

enum Mood: String, CaseIterable, Identifiable, Codable, Equatable {
    case happy, sad, angry, tired, excited, neutral, anxious

    var id: String { rawValue }

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

@Model
class Retrospect: Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var date: Date
    var category: RetrospectCategory
    var mood: Mood

    init(title: String, content: String, date: Date, category: RetrospectCategory, mood: Mood) {
        self.title = title
        self.content = content
        self.date = date
        self.category = category
        self.mood = mood
    }
}
