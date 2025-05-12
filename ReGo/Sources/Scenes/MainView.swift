//
//  Tabiew.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            ListView(items: Retrospect.sampleData)
                .tabItem {
                    Label("목록", systemImage: "list.bullet.clipboard")
                }
            StatisticsView()
                .tabItem {
                    Label("통계", systemImage: "pencil.slash")
                }
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
        }

    }
}

#Preview {
    MainView()
}
