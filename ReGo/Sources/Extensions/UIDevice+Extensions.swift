//
//  UIDevice+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import SwiftUI

extension UIDevice {

    /// 현재 사용중인 Device가 Pad면 true, 아니면 false
    /// iPad UI 대응 체크 변수
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
