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
    private var bubbleShowUpTimer: Timer? = nil
    
    let bubbleSize: CGFloat = 40
//    private let bubbleQueue = DispatchQueue(label: "bubble.background.queue", qos: .userInitiated)
    
    init(gameDuration: Int, maxBubbles: Int, playerName: String) {
        self.gameDuration = gameDuration
        self.maxBubbles = maxBubbles
        self.playerName = playerName
        self.remainingTime =  Double(gameDuration)
    }
    
    // Start the game by initializing the timer and setting the end time
    func start() {
        // Game timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.gameOver = true
                self.stop()
            }
        }
        
        // Bubble show up interval
        bubbleShowUpTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { _ in
            self.updateBubbles()
        }
    }

    // Stop the game by invalidating the timer
    func stop() {
        bubbles.removeAll()
        timer?.invalidate()
        bubbleShowUpTimer?.invalidate()
        timer = nil
        bubbleShowUpTimer = nil
    }

    // Function to pop a bubble and update the score
    func popBubble(_ bubble: Bubble) -> Double {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index) // Remove the popped bubble

            // Award points based on the color sequence
            let received = (self.lastBubbleColor == bubble.color) ? bubble.points * 1.5 : bubble.points
            score += received
            lastBubbleColor = bubble.color
            
            return received
        }
        return 0
    }

    // Function to update the list of bubbles
    func updateBubbles() {
        var newBubbles: [Bubble] = []
        var tries = 0
        let numBubbles = Int.random(in: 1...maxBubbles)
        // Create new bubbles ensuring they don't overlap
        while newBubbles.count < numBubbles && tries < 50 { // Limit retries to avoid infinite loops
            let bubble = Bubble(size: self.bubbleSize)
            
            let overlaps = newBubbles.contains { $0.overlaps(with: bubble) }
            if !overlaps {
                newBubbles.append(bubble) // Add non-overlapping bubble
            }

            tries += 1
        }

        // Replace the existing bubbles with the new non-overlapping set
        self.bubbles = newBubbles
    }
}
