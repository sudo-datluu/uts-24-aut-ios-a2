//
//  GameSettingView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct GameSettingView: View {
    var scoreController: ScoreController
    @State private var playerName: String = "player"
    @State private var gameDuration: Double = 60 // Default game time in seconds
    @State private var maxBubbles: Double = 15 // Default maximum number of bubbles
    @State private var startGame: Bool = false // State to control when to start the game

    
    var body: some View {
        Text("Game setting")
            .foregroundColor(.red)
            .font(.title)
        Spacer()
        
        //Set up player name
        HStack {
            Text("Your name: ")
            TextField(
                "Enter name",
                text: $playerName
            )
            .textFieldStyle(.roundedBorder)
        }.padding()
        

        //Set up game duration
        Text("Game Duration: \(Int(gameDuration)) seconds")
        Slider(value: $gameDuration, in: 10...100, step: 1).padding()
        
        //Set up max number of bubbles
        Text("Max number of bubbles: \(Int(maxBubbles))")
        Slider(value: $maxBubbles, in: 1...15, step: 1).padding()
        
        //Start the game
        NavigationLink(
            destination: StartGameView(
                gameController: GameController(gameDuration: Int(gameDuration), maxBubbles: Int(maxBubbles), playerName: playerName), scoreController: scoreController
            ).navigationBarBackButtonHidden(true),
            label: {
                Text("Start")
                    .foregroundColor(.red)
                    .font(.title)
            }
        )
        Spacer()
    }
}

#Preview {
    GameSettingView(scoreController: ScoreController())
}
