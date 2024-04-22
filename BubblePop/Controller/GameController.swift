import SwiftUI
import Foundation

class GameController: ObservableObject {
    @Published var bubbles: [Bubble] = [] // List of bubbles in the game
    @Published var score: Double = 0 // Player's score
    @Published var gameOver: Bool = false // Game over state
    
    var gameDuration: Int // Duration of the game
    var maxBubbles: Int // Maximum number of bubbles allowed
    var playerName: String // Player's name
    var lastBubbleColor: Color? // Saved last pop bubble color
    var remainingTime: Double
    private var timer: Timer? = nil // Game timer
    
    let bubbleSize: CGFloat = 60
    
    init(gameDuration: Int, maxBubbles: Int, playerName: String) {
        self.gameDuration = gameDuration
        self.maxBubbles = maxBubbles
        self.playerName = playerName
        self.remainingTime =  Double(gameDuration)
    }
    
    // Start the game by initializing the timer and setting the end time
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            self.updateBubbles()
            self.remainingTime -= 0.25
            if self.remainingTime <= 0 {
                self.gameOver = true
                self.stop()
            }
        }

        
    }

    // Stop the game by invalidating the timer
    func stop() {
        bubbles.removeAll()
        timer?.invalidate()
        timer = nil
    }

    // Function to pop a bubble and update the score
    func popBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index) // Remove the popped bubble

            // Award points based on the color sequence
            if self.lastBubbleColor == bubble.color {
                score += bubble.points * 1.5 // 1.5 times bonus
            } else {
                score += bubble.points // Default points for popping a bubble
            }
            lastBubbleColor = bubble.color
        }
    }

    // Function to update the list of bubbles
    func updateBubbles() {
        // If too many bubbles, remove one at random
        if bubbles.count >= maxBubbles {
            let randomIndex = Int.random(in: 0..<bubbles.count)
            bubbles.remove(at: randomIndex)
        }

        // Add a new random bubble with non-overlapping positions
        let randomX = CGFloat.random(in: bubbleSize...(UIScreen.main.bounds.width - bubbleSize))
        let randomY = CGFloat.random(in: bubbleSize...(UIScreen.main.bounds.height - bubbleSize))
        let newBubble = Bubble(position: CGPoint(x: randomX, y: randomY))

        // Ensure no overlap with existing bubbles
        if !bubbles.contains(where: { $0.overlaps(with: newBubble) }) {
            bubbles.append(newBubble)
        }
    }
}
