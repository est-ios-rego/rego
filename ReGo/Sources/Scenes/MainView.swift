//
//  Tabiew.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

struct MainView: View {
    @SceneStorage("selectedTab") private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
                .tag(0)

            ListView(items: Retrospect.sampleData)
                .tabItem {
                    Label("home", systemImage: "list.bullet.clipboard")
                }
                .tag(1)

            StatisticsView()
                .tabItem {
                    Label("home", systemImage: "pencil.slash")
                }
                .tag(2)
            SettingView()
                .tabItem {
                    Label("home", systemImage: "gear")
                }
                .tag(3)
        }

    }
}

#Preview {
    MainView()
}
