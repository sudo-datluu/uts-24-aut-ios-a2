//
//  BombModel.swift
//  BubblePop
//
//  Created by David on 25/4/2024.
//

import SwiftUI
import Foundation

// Bomb model that would double player score
struct BombModel: Identifiable {
    let id = UUID() // Unique identifier
    var position: CGPoint // Current position
    var size: CGFloat = 50 // Size of the bomb
    var movementDirection: CGFloat = CGFloat.random(in: 0...360) // Random movement direction
    
    // Move the bomb based on its current direction
    mutating func move() {
        let speed: CGFloat = 15 // Speed of the bomb
        let radians = movementDirection * (.pi / 180) // Convert degrees to radians
        let x = cos(radians) * speed
        let y = sin(radians) * speed
        position.x += x
        position.y += y
    }
}
