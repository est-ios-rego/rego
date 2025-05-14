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

    private let container: ModelContainer = {
        do {
            return try ModelContainer(for: Retrospect.self)
        } catch {
            fatalError("Model container initialization failed: \(error)")
        }
    }()


    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(AppTheme(rawValue: appThemeRaw)?.colorScheme)
        }
        .modelContainer(container)
    }
}
