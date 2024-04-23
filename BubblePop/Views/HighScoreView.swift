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
                    .foregroundColor(.red)
                    .font(.title)
                    .padding(50)
                
                NavigationLink(
                    destination: GameSettingView(scoreController: scoreController),
                    label: {
                        Text("New Game")
                            .font(.title)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                )
                if isLoaded {
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
        }

    private func loadScores() {
        scoreController.load() // Load scores
        isLoaded = true // Set the loading state to true once done
    }
}

