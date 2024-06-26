//
//  ScoreModel.swift
//  BubblePop
//
//  Created by David on 22/4/2024.
//

import Foundation
// Model to present score of the player
struct ScoreModel : Codable {
    var playerName: String
    var score: Double
    var id: UUID
    
    init(playerName: String, score: Double) {
        self.playerName = playerName
        self.score = score
        self.id = UUID()
    }
}
