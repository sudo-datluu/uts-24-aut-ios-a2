//
//  ContentView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreController = ScoreController() // Score controller for the app
    var body: some View {
        NavigationView {
            VStack {
                //Title
                Text("Bubble Pop")
                    .foregroundColor(.red)
                    .font(.largeTitle)
                Spacer()
                
                // Navigate to game setting
                NavigationLink(
                    destination: GameSettingView(scoreController: scoreController), 
                    label: {
                        Text("New Game")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                )
                .padding(50)
                
                //Navigate to leaderboard
                NavigationLink(
                    destination: HighScoreView(scoreController: scoreController),
                    label: {
                        Text("Leaderboard")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                )
                Spacer()
                
            }
            .padding()
        }
    }
}
