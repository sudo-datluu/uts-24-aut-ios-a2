//
//  BubbleModel.swift
//  BubblePop
//
//  Created by David on 19/4/2024.
//

import SwiftUI
import CoreGraphics

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    let points: Int
    let position: CGPoint
    let creationTime: Date

    // A dictionary to associate colors with points
    static let colorPoints: [Color: Int] = [
        .red: 1,
        .pink: 2,
        .green: 5,
        .blue: 8,
        .black: 10
    ]

    static func randomColorAndPoints() -> (Color, Int) {
        // Define a color with its associated probability
        let colorProbabilities = [
            (Color.red, 40),
            (Color.pink, 30),
            (Color.green, 15),
            (Color.blue, 10),
            (Color.black, 5)
        ]

        // Create an array where each color appears with its probability
        var colorChoices: [(Color, Int)] = []
        for (color, probability) in colorProbabilities {
            if let points = colorPoints[color] {
                for _ in 0..<probability {
                    colorChoices.append((color, points))
                }
            }
        }

        // Randomly select a color and its associated points from the array
        return colorChoices.randomElement() ?? (.red, colorPoints[.red]!)
    }

    init(position: CGPoint, creationTime: Date = Date()) {
        self.position = position
        self.creationTime = creationTime
        let randomColorAndPoints = Bubble.randomColorAndPoints()
        self.color = randomColorAndPoints.0
        self.points = randomColorAndPoints.1
    }
}
