//
//  ScoreModel.swift
//  BubblePop
//
//  Created by David on 22/4/2024.
//

import Foundation
struct ScoreModel : Identifiable {
    var playerName: String
    var score: Double
    let id = UUID()
    
    
    init(playerName: String, score: Double) {
        self.playerName = playerName
        self.score = score
    }
}
