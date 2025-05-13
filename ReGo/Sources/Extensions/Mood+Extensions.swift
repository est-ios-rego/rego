//
//  RetroSpect+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/13/25.
//

import Foundation
import SwiftUI

extension Mood {
    var color: Color {
        switch self {
        case .happy: return Color(red: 255 / 255, green: 205 / 255, blue: 250 / 255)
        case .sad: return Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
        case .angry: return Color(red: 240 / 255, green: 128 / 255, blue: 128 / 255)
        case .tired: return Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255)
        case .excited: return Color(red: 255 / 255, green: 192 / 255, blue: 203 / 255)
        case .neutral: return Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255)
        case .anxious: return Color(red: 240 / 255, green: 255 / 255, blue: 240 / 255)
        }
    }
}
