//
//  HighScoreView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    @State var scoreController : ScoreController // Score management
    @State private var isLoaded = false
    
        var body: some View {
            VStack {
                Text("High scores")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                // Wait until the score is load
                if isLoaded {
                    // Show list of the high score
                    List(scoreController.getScores().enumerated().map { $0 }, id: \.element.id) { index, score in
                        HStack {
                            Text("Rank \(index+1): ")
                            Text(score.playerName)
                            Spacer()
                            let stringScore = String(format: "%.1f", score.score)
                            Text("\(stringScore)")
                        }
                    }
                } else {
                    Text("Loading High Scores...")
                }
                
            }
            .onAppear {
                loadScores() // Load scores when view appears
            }
            // Start new game
            NavigationLink(
                destination: GameSettingView(scoreController: scoreController),
                label: {
                    Text("New Game")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )
        }

    private func loadScores() {
        scoreController.load() // Load scores
        isLoaded = true // Set the loading state to true once done
    }
}

#Preview {
    HighScoreView(scoreController: ScoreController())
}
