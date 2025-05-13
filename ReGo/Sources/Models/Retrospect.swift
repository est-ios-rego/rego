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

@Model
class Retrospect: Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var date: Date
    var category: RetrospectCategory

    init(title: String, content: String, date: Date, category: RetrospectCategory) {
        self.title = title
        self.content = content
        self.date = date
        self.category = category
    }
}
