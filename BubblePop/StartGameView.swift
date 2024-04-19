//
//  StartGameView.swift
//  BubblePop
//
//  Created by David on 2/4/2024.
//

import SwiftUI

struct StartGameView: View {
    @State private var bubbles = [Bubble]()
    @State private var score = 0
    let bubbleSize: CGFloat = 60
    
    var body: some View {
        VStack{
            Text("Score: \(score)")
                .font(.headline)
                .padding()
            
            ZStack {
                ForEach(bubbles) {
                    bubble in Circle()
                        .foregroundColor(bubble.color)
                        .frame(width: bubbleSize, height: bubbleSize)
                        .position(bubble.position)
                        .onTapGesture {
                            popBubble(bubble)
                        }
                }
            }
            .onAppear {
//                startGame()
            }
        }
    }
    
    func startGame() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            _ in generateBubble()
        }
    }
    
    func generateBubble() {
        let randomX = CGFloat.random(in: 0...(UIScreen.main.bounds.width - bubbleSize / 2))
        let randomY = CGFloat.random(in: 0...(UIScreen.main.bounds.height - bubbleSize / 2))
        let bubble = Bubble(position: CGPoint(x: randomX, y: randomY))
        bubbles.append(bubble)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            removeBubble(bubble)
        }
    }
    
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(of: bubble) {
            bubbles.remove(at: index)
        }
    }
    
    func popBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(of: bubble) {
            bubbles.remove(at: index)
            score += bubble.points
        }
    }
}

#Preview {
    StartGameView()
}
