//
//  GameSettingView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct GameSettingView: View {
    @StateObject var highScoreViewModel = HighScoreViewModel()
    @State private var countdownInput = ""
    @State private var countdownValue: Double = 60
    @State private var numberBubbles: Double = 15
    
    var body: some View {
        Label("Game setting", systemImage: "")
            .foregroundColor(.red)
            .font(.title)
        Spacer()
        Text("Enter your name")
        TextField(
            "Enter name",
            text: $highScoreViewModel.taskDescription
        ).padding()
        
        Text("Game Time")
        Slider(value: $countdownValue, in: 60...100, step: 1).padding()
        Text("\(Int(countdownValue))").padding()
        Text("Max number of bubbles")
        Slider(value: $numberBubbles, in: 1...15, step: 1).padding()
        Text("\(Int(numberBubbles))").padding()
        NavigationLink(
            destination: StartGameView(),
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
