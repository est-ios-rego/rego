//
//  EmptyComponent.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import Foundation
import SwiftUI
import SwiftData

enum RestrospectCategory: String, Codable {
    case a = "카테고리a"
    case b = "카테고리b"
    case c = "카테고리c"
}

@Model
class Restrospect: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var category: RestrospectCategory
    var title: String
    var content: String

    init(date: Date, category: RestrospectCategory, title: String, content: String) {
        self.date = date
        self.category = category
        self.title = title
        self.content = content
    }
}
