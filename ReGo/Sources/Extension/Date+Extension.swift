//
//  Date+Extension.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import Foundation

extension Date {
    var toListDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
