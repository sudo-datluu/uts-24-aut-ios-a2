//
//  GameSettingView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct GameSettingView: View {
    @State private var playerName: String = "player"
        @State private var gameDuration: Double = 60 // Default game time in seconds
        @State private var maxBubbles: Double = 10 // Default maximum number of bubbles
        @State private var startGame: Bool = false // State to control when to start the game

    
    var body: some View {
        Text("Game setting")
            .foregroundColor(.red)
            .font(.title)
        Spacer()
        Text("Enter your name")
        TextField(
            "Enter name",
            text: $playerName
        ).padding()
        
        Text("Game Time")
        Slider(value: $gameDuration, in: 0...100, step: 1).padding()
        Text("\(Int(gameDuration))").padding()
        Text("Max number of bubbles")
        Slider(value: $maxBubbles, in: 1...15, step: 1).padding()
        Text("\(Int(maxBubbles))").padding()
        NavigationLink(
            destination: StartGameView(
                gameController: GameController(gameDuration: Int(gameDuration), maxBubbles: Int(maxBubbles), playerName: playerName)
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
    GameSettingView()
}
