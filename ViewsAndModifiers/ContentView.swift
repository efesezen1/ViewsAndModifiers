import SwiftUI

struct ContentView: View {
    enum Gestures: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissor = "Scissor"
        
        // Add emoji representation for each gesture
        var emoji: String {
            switch self {
            case .rock:
                return "🪨" // Rock emoji
            case .paper:
                return "📄" // Paper emoji
            case .scissor:
                return "✂️" // Scissors emoji
            }
        }
    }
    
    let gestures: [Gestures: Gestures] = [
        .rock: .scissor,
        .paper: .rock,
        .scissor: .paper
    ]
    
    @State private var score: Int = 0
    
    // Random gesture as a non-optional String
    @State private var randomGesture: Gestures = Gestures.allCases.randomElement() ?? .scissor
    
    var gameContinues: Bool {
        return score < 3
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            AngularGradient(
                colors: [.red, .yellow, .orange, .cyan],
                center: .top, startAngle: .degrees(0),
                endAngle: .degrees(180))
            .ignoresSafeArea()
            
            if gameContinues {
                VStack {
                    // Display the random gesture with emoji
                    Spacer()
                    Section {
                        Text("\(randomGesture.rawValue) \(randomGesture.emoji)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                    }
                    VStack(spacing: 10) {
                        // List gestures with emojis
                        ForEach(Array(gestures), id: \.key) { key, value in
                            Button() {
                                print("\(value.rawValue)")
                                checkAnswer(value.rawValue)
                            } label: {
                                HStack {
                                    Text(key.emoji) // Display the emoji for the gesture
                                        .font(.largeTitle) // Adjust the size of the emoji
                                    
                                    Text("\(key.rawValue)") // Text next to the emoji
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .frame(width: 200)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(50)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    Spacer()
                    Text("Current score is \(score)")
                }
                .padding()
            } else {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("Your score is \(score)").font(.title2.bold())
                }
            }
        }
    }
    
    // Function to check if the answer matches the random gesture
    func checkAnswer(_ answer: String) {
        if answer == randomGesture.rawValue {
            print("Correct answer \(answer) equals \(randomGesture.rawValue)")
            score += 1
            randomGesture = Gestures.allCases.randomElement() ?? .scissor
        } else {
            if score > 0 {
                score -= 1
            }
        }
    }
}

#Preview {
    ContentView()
}
