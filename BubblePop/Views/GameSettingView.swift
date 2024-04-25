import SwiftUI

struct GameSettingView: View {
    var scoreController: ScoreController
    @State private var playerName: String = "player"
    @State private var gameDuration: Double = 60 // Default game time in seconds
    @State private var maxBubbles: Double = 15 // Default maximum number of bubbles
    @State private var startGame: Bool = false // State to control when to start the game
    
    // List that instruct the scoring
    private let colorPointsInstruction: [(Color, String)] = [
        (.red, "1pts"),
        (.pink, "2pts"),
        (.green, "5pts"),
        (.blue, "8pts"),
        (.black, "10pts"),
        (.orange, "Double your score")
    ]
    var body: some View {
        VStack {
            // Title
            Text("Game Settings")
                .foregroundColor(.blue)
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)

            Spacer()

            // Section: Player Information
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Your name:")
                    TextField("Enter name", text: $playerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            .padding(.horizontal)

            Spacer()

            // Section: Game Configuration
            VStack(alignment: .leading) {

                Text("Game Duration: \(Int(gameDuration)) seconds")
                Slider(value: $gameDuration, in: 10...100, step: 1)
                    .padding(.horizontal)

                Text("Max Number of Bubbles: \(Int(maxBubbles))")
                Slider(value: $maxBubbles, in: 1...15, step: 1)
                    .padding(.horizontal)
            }
            .padding(.horizontal)

            Spacer()
            
            // Scoring instruction
            VStack(alignment: .leading) {
                List(colorPointsInstruction, id: \.0) { object in
                    HStack {
                        // Render circle if the color is not orange
                        // Else rectangle would be double the score
                        if object.0 != Color.orange {
                            Circle()
                            .fill(object.0)
                            .frame(width: 20, height: 20)
                        } else {
                            Rectangle()
                            .fill(object.0)
                            .frame(width: 20, height: 20)
                        }
                        
                        Text(object.1) // Object score
                    }
                }
                .padding(.top, 10) // Padding to separate from list
                .padding(.horizontal) // Consistent padding
            }

            Spacer()
            // Start Game
            NavigationLink(
                destination: StartGameView(
                    gameController: GameController(
                        gameDuration: Int(gameDuration),
                        maxBubbles: Int(maxBubbles),
                        playerName: playerName
                    ),
                    scoreController: scoreController
                ).navigationBarBackButtonHidden(true),
                label: {
                    Text("Start Game")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )
            Spacer()
        }
    }
    
}

#Preview {
    GameSettingView(scoreController: ScoreController())
}
