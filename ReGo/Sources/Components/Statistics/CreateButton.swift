//
//  CreateButton.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/15/25.
//

import Foundation
import SwiftUI
import SwiftData

/// 새로운 회고 작성 유도 버튼 뷰.
struct CreateButton: View {
    /// 버튼 표시 텍스트.
    var buttonText: String

    /// 회고 수정 화면 표시 여부 제어 바인딩 변수.
    @Binding var showEditView: Bool

    var body: some View {
        Button {
            showEditView = true
        } label: {
            Text(buttonText)
                .tint(Color.appAccent)
                .bold()
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.7))
                }
        }
        .navigationDestination(isPresented: $showEditView) {
            EditView(mode: .create, retro: Retrospect.emptyData)
        }
    }
}
