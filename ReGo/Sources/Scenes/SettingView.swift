//
//  SettingView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("appTheme") private var appThemeRaw: String = AppTheme.system.rawValue

    var body: some View {
        List {
            Section(header: Text("테마")) {
                ForEach(AppTheme.allCases) { theme in
                    HStack {
                        Text(theme.displayName)

                        Spacer()

                        if theme.rawValue == appThemeRaw {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            appThemeRaw = theme.rawValue
                        }
                    }
                }
            }
            .listRowBackground(Color.regoBackground2)
        }
        .scrollContentBackground(.hidden)
        .background(Color.regoBackground)
    }
}

#Preview {
    SettingView()
}
