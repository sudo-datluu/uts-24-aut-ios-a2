//
//  ScreenStat.swift
//  BubblePop
//
//  Created by David on 26/4/2024.
//

import Foundation
import UIKit

struct ScreenStat {
    var height : CGFloat
    var width : CGFloat
    
    init () {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        height = window?.screen.bounds.height ?? 0
        width = window?.screen.bounds.width ?? 0
    }
}
