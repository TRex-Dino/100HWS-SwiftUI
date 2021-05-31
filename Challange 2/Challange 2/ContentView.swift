//
//  ContentView.swift
//  Challange 2
//
//  Created by Dmitry on 31.05.2021.
//

import SwiftUI

struct ContentView: View {
    let youPlays = ["👊", "✋", "✌️"]
    @State private var compChoice = ["👊", "✋", "✌️"].shuffled()
    @State private var correctChoise = true
    @State private var playdTurn = false
    @State private var compNumber = 0
    @State private var userAnswer = 0
    @State private var score = 0
    @State private var userTextAnswer = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Rock - Paper - Scissors")
                    .bold()
                    .italic()
                    .foregroundColor(.yellow)
                    .font(.title)
                    .padding()
                
                Spacer()
                VStack(spacing: 30) {
                    Text("Computer choice:")
                        .styledScore()
                    if playdTurn {
                        Text(youPlays[compNumber])
                            .styledButton()
                    } else {
                        Text("?")
                            .foregroundColor(.white)
                            .styledButton()
                    }
                }
                Section {
                    Text("Your choice: ")
                        .styledScore()
                }
                
                Section {
                    HStack {
                        ForEach(0..<youPlays.count, id: \.self) {index in
                            Button(action: {
                                //some action
                                compNumber = randomNumber()
                                checkAnswer(notuserAnswer: index)
                                playdTurn = true
                            }) {
                                Text(self.youPlays[index])
                                    .styledButton()
                            }
                        }
                    }
                }
                
                Section {
                    Text("Your score: \(score)")
                        .styledScore()
                }
                Spacer()
                
            }
            .alert(isPresented: $playdTurn, content: {
                Alert(title: Text("YOU'RE \(userTextAnswer)"), dismissButton: .default(Text("Continue")) {
                    playdTurn = false
                })
            })
        }
    }
    private func checkAnswer(notuserAnswer: Int) {
        if notuserAnswer == compNumber {
            score += 1
            userTextAnswer = "RIGHT"
        } else {
            score -= 1
            userTextAnswer = "WRONG"
        }
    }
    
    private func randomNumber() -> Int {
        Int.random(in: 0..<2)
    }
    
    private func calculateChoice() {
        
    }
}


struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 80, height: 60, alignment: .center)
            .background(Color.black)
            .clipShape(Capsule())
    }
}
struct PlayButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.black)
            .frame(width: 100, height: 60, alignment: .center)
            .background(Color.yellow)
            .clipShape(Capsule())
    }
}

struct ScoreStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
    }
}

extension View {
    func styledButton() -> some View {
        self.modifier(ButtonStyle())
    }
    
    func styledScore() -> some View {
        self.modifier(ScoreStyle())
    }
    
    func styledPlayButton() -> some View {
        self.modifier(PlayButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
