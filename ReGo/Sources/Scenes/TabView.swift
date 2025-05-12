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
                    Label("home", systemImage: "house")
                }
            ListView()
                .tabItem {
                    Label("home", systemImage: "list.bullet.clipboard")
                }
            StatisticsView()
                .tabItem {
                    Label("home", systemImage: "pencil.slash")
                }
            SettingView()
                .tabItem {
                    Label("home", systemImage: "gear")
                }
        }

    }
}

#Preview {
    MainView()
}
