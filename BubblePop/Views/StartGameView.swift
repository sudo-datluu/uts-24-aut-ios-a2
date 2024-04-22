//
//  StartGameView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct StartGameView: View {
    @ObservedObject var gameController: GameController // Game controller to manage logic
    var scoreController : ScoreController = ScoreController()
    @State private var gameOver : Bool = false
    var body: some View {
        VStack {
            // Display the current score
            HStack {
                let stringScore = String(format: "%.2f", gameController.score)
                Text("Score: \(stringScore)")
                    .padding()
                
                Text("Time remains: \(Int(gameController.remainingTime))")
                    .padding()
            }
            
            if (gameOver) {
                NavigationLink(
                    destination: GameSettingView(),
                    label: {
                        Text("New Game")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                ).navigationBarBackButtonHidden(true)
                .padding(50)
                NavigationLink(
                    destination: HighScoreView().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Leaderboard")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                )
            }

            ZStack {
                // Display each bubble from the game controller
                ForEach(gameController.bubbles) { bubble in
                    Circle()
                        .frame(width: gameController.bubbleSize, height: gameController.bubbleSize)
                        .position(x: bubble.position.x, y: bubble.position.y)
                        .foregroundColor(bubble.color)
                        .onTapGesture {
                            gameController.popBubble(bubble) // Pop the bubble on tap
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .onAppear {
            gameController.start() // Start the game when the view appears
        }
        .onDisappear {
            gameController.stop() // Stop the game when the view disappears
            let score = ScoreModel(playerName: gameController.playerName, score: gameController.score)
            scoreController.save(score: score)
            
        }
        .alert(isPresented: $gameController.gameOver) {
            Alert(
                title: Text("Game Over"),
                dismissButton: .default(Text("OK"), action: {
                    gameOver = true
                })
            )
        }
    }
}

#Preview {
    StartGameView(gameController: GameController(gameDuration: 10, maxBubbles: 5, playerName: "abc"))
}
