import SwiftUI
import Foundation

class GameController: ObservableObject {
    @Published var bubbles: [Bubble] = [] // List of bubbles in the game
    @Published var bombs: [BombModel] = [] // List of bombs
    @Published var score: Double = 0 // Player's score
    @Published var gameOver: Bool = false // Game over state
    
    var gameDuration: Int // Duration of the game
    var maxBubbles: Int // Maximum number of bubbles allowed
    var playerName: String // Player's name
    var lastBubbleColor: Color? // Saved last pop bubble color
    var remainingTime: Double
    private var gameTimer: Timer? = nil // Game timer
    private var bubbleTimer: Timer? = nil // Bubble show up timer
    private var bombTimer: Timer? = nil // Bomb timer
    
    let bubbleSize: CGFloat = 40
    
    init(gameDuration: Int, maxBubbles: Int, playerName: String) {
        self.gameDuration = gameDuration
        self.maxBubbles = maxBubbles
        self.playerName = playerName
        self.remainingTime =  Double(gameDuration)
    }
    
    // Start the game by initializing the timer and setting the end time
    func start() {
        // Game timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.gameOver = true
                self.stop()
            }
        }
        
        // Bubble show up interval
        bubbleTimer = Timer.scheduledTimer(withTimeInterval: 2.8, repeats: true) { _ in
            self.updateBubbles()
        }
        
        // Bomb timer
        bombTimer = Timer.scheduledTimer(withTimeInterval: 1/30, repeats: true) { _ in
            self.updateBombs()
        }
    }

    // Stop the game by invalidating the timer
    func stop() {
        bubbles.removeAll()
        bombs.removeAll()
        gameTimer?.invalidate()
        bubbleTimer?.invalidate()
        bombTimer?.invalidate()
        gameTimer = nil
        bubbleTimer = nil
        bombTimer = nil
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
    
    // Function to handle bomb interaction
    func touchBomb(_ bomb: BombModel) {
        score *= 2 // Double the score
        bombs.removeAll { $0.id == bomb.id } // Remove the bomb
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
    
    // Function to update the list of the bombs
    func updateBombs() {
        for index in bombs.indices {
            bombs[index].move() //move the bomb
        }
        
        // Filter out-of-bounds bombs
        bombs = bombs.filter { bomb in
            bomb.position.x >= 0 && bomb.position.x <= UIScreen.main.bounds.width &&
            bomb.position.y >= 0 && bomb.position.y <= UIScreen.main.bounds.height
        }
        
        // Bomb would appear with 10%
        if Double.random(in: 0...1) <= 0.05 {
            let randomX = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let randomY = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            bombs.append(BombModel(position: CGPoint(x: randomX, y: randomY)))
        }
    }
    
    // Update game
    func update() {
        updateBubbles()
        updateBombs()
    }
}
