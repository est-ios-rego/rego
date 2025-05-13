//
//  ReGoApp.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct ReGoApp: App {
    @AppStorage("appTheme") private var appThemeRaw: String = AppTheme.system.rawValue
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(AppTheme(rawValue: appThemeRaw)?.colorScheme)
        }
        .modelContainer(for: Retrospect.self)
    }
}
