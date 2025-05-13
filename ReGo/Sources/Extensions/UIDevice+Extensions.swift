//
//  UIDevice+Extensions.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import SwiftUI

extension UIDevice {
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
