//
//  HighScoreView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    @State private var scoreController = ScoreController() // Score management
        
        var body: some View {
            VStack {
                Text("High scores")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding(50)
                
                NavigationLink(
                    destination: GameSettingView(),
                    label: {
                        Text("New Game")
                            .font(.title)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                )
                List(scoreController.getScores().enumerated().map { $0 }, id: \.element.id) { index, score in
                    HStack {
                        Text("Rank \(index+1): ")
                        Text(score.playerName)
                        Spacer()
                        let stringScore = String(format: "%.2f", score.score)
                        Text("\(stringScore)")
                    }
                }
            }
            .onAppear {
                scoreController.load() // Load scores when view appears
            }
        }

    // Function to load high scores from the JSON file
}

#Preview {
    HighScoreView()
}
