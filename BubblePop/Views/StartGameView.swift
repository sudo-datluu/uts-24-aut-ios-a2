//
//  StartGameView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct StartGameView: View {
    @ObservedObject var gameController: GameController // Game controller to manage logic
    var scoreController : ScoreController
    @State private var gameOver : Bool = false
    
    @State private var receivedScores: [AnimatedScoreModel] = [] // Track received scores
    @State private var bonusScores: [AnimatedScoreModel] = [] // Track deducted scores
    @State private var scoreTimer: Timer? = nil // Timer for score visibility
    var body: some View {
        VStack {
            // Display the current score, time remain and highest score
            HStack {
                let stringScore = String(format: "%.1f", gameController.score)
                Text("Score: \(stringScore)")
                    .padding()
                
                Text("Time remains: \(Int(gameController.remainingTime))")
                    .padding()
                
                // Landscape
                if UIDevice.current.orientation.rawValue >= 3 {
                    Text("High score: \(scoreController.getHighScore())")
                        .padding()
                }
            }
            // Potrait
            if UIDevice.current.orientation.rawValue <= 1 {
                Text("High score: \(scoreController.getHighScore())")
                    .padding()
            }
            
            // Show navigation if the game is over
            if (gameOver) {
                // Start new game
                NavigationLink(
                    destination: GameSettingView(scoreController: scoreController),
                    label: {
                        Text("New Game")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                ).navigationBarBackButtonHidden(true)
                .padding(50)
                
                // Check leaderboard
                NavigationLink(
                    destination: HighScoreView(scoreController: scoreController).navigationBarBackButtonHidden(true),
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
                            let received = gameController.popBubble(bubble) // Pop the bubble on tap
                            executeAnimateForScore(received, at: bubble.position, targetScores: &receivedScores)
                        }
                }
                
                // Display each bomb from the game controller
                ForEach(gameController.bombs) { bomb in
                    Rectangle()
                        .frame(width: bomb.size, height: bomb.size)
                        .position(x: bomb.position.x, y: bomb.position.y)
                        .foregroundColor(.orange)
                        .onTapGesture {
                            gameController.touchBomb(bomb) // Double the score when touched
                            executeAnimateForScore(0, at: bomb.position, targetScores: &bonusScores)
                        }
                }
                
                // Display received score for the bubble
                ForEach(receivedScores) { animatedScore in
                    Text("+\(animatedScore.value.formatted())")
                        .position(animatedScore.position)
                        .foregroundColor(.green)
                        .font(.system(size: 36))
                        
                        .transition(.opacity) // Fade-in effect
                        .animation(.easeInOut, value: 1) // Control the duration of visibility
                }
                
                // Display bonus score for the bomb
                ForEach(bonusScores) { animatedScore in
                    Text("x2 Scores")
                        .position(animatedScore.position)
                        .foregroundColor(.red)
                        .font(.system(size: 36))
                        .transition(.opacity) // Fade-in effect
                        .animation(.easeInOut, value: 1) // Control the duration of visibility
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            

        }
        .onAppear {
            gameController.start() // Start the game when the view appears
        }
        .onDisappear {
            gameController.stop() // Stop the game when the view disappears
        }
        // Alert game over and score of the player
        .alert(isPresented: $gameController.gameOver) {
            Alert(
                title: Text("Game Over. Your score: \(gameController.score.formatted())"),
                dismissButton: .default(Text("OK"), action: {
                    gameOver = true
                    let score = ScoreModel(playerName: gameController.playerName, score: gameController.score)
                    scoreController.save(score: score)
                })
            )
        }
    }
    
    private func executeAnimateForScore(_ score: Double, at position: CGPoint, targetScores: inout [AnimatedScoreModel]) {
        let animatedScore = AnimatedScoreModel(value: score, position: position)
        targetScores.append(animatedScore) // Add the animated score to the list

        // Timer to remove the animated score after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.receivedScores.removeAll { $0.id == animatedScore.id }
                self.bonusScores.removeAll { $0.id == animatedScore.id }
            }
        }
    }
}

#Preview {
    StartGameView(gameController: GameController(gameDuration: 20, maxBubbles: 15, playerName: "abc"), scoreController: ScoreController())
}
