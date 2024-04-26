//
//  BubbleModel.swift
//  BubblePop
//
//  Created by David on 19/4/2024.
//

import SwiftUI
import CoreGraphics

// Model present bubble appear on the screen
struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    let points: Double
    var position : CGPoint
    let creationTime: Date
    let size: CGFloat

    // A dictionary to associate colors with points
    static let colorPoints: [Color: Double] = [
        .red: 1,
        .pink: 2,
        .green: 5,
        .blue: 8,
        .black: 10
    ]

    static func randomColorAndPoints() -> (Color, Double) {
        // Define a color with its associated probability
        let colorProbabilities = [
            (Color.red, 40),
            (Color.pink, 30),
            (Color.green, 15),
            (Color.blue, 10),
            (Color.black, 5)
        ]

        // Create an array where each color appears with its probability
        var colorChoices: [(Color, Double)] = []
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
    
    // Check if this bubble overlaps with another
    func overlaps(with other: Bubble) -> Bool {
        let distance = sqrt(pow(self.position.x - other.position.x, 2) + pow(self.position.y - other.position.y, 2))
        return distance < (size * 2) // If distance is less than double the size, they overlap
    }
    
    // Get random location
    static func randomLocation(bubbleSize: CGFloat) -> CGPoint {
        let offsetX = UIDevice.current.orientation.rawValue < 3 ? 0 : 100
        let offsetY = UIDevice.current.orientation.rawValue < 3 ? 200 : 120
        
        let randomX = CGFloat.random(in: bubbleSize...(UIScreen.main.bounds.width - bubbleSize - CGFloat(offsetX)))
        let randomY = CGFloat.random(in: bubbleSize...(UIScreen.main.bounds.height - bubbleSize - CGFloat(offsetY)))
        return CGPoint(x: randomX, y: randomY)
    }

    init(size: CGFloat, creationTime: Date = Date()) {
        self.creationTime = creationTime
        let randomColorAndPoints = Bubble.randomColorAndPoints()
        self.color = randomColorAndPoints.0
        self.points = randomColorAndPoints.1
        self.size = size
        self.position = Bubble.randomLocation(bubbleSize: size)
    }
}
