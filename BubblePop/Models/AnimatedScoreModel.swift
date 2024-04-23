//
//  AnimatedScoreModel.swift
//  BubblePop
//
//  Created by David on 23/4/2024.
//

import Foundation
// Model to represent animated scores
struct AnimatedScoreModel: Identifiable {
    let id = UUID()
    let value: Double
    var position: CGPoint
}
