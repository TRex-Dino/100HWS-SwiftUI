//
//  ContentView.swift
//  Challange 3
//
//  Created by Dmitry on 03.06.2021.
//

import SwiftUI

struct ContentView: View {
    private let numberOfQuestionArray = ["5", "10", "15", "25"]
    @State private var numberOfQuestion = 0
    @State private var currentQusetion = 1
    @State private var lastGame = 1
    @State private var selectedQuestions = 0
    @State private var multiple = 7
    @State private var nameOfGame = "Start"
    @State private var gameIsStart = false
    @State private var gameIsEnd = false
    @State private var textAnswer = ""
    @State private var score = 0
    @State private var numberOne = 0
    @State private var numberTwo = 0
    @State private var complitedString = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 25) {
                Picker(selection: $selectedQuestions, label: Text("Picker")) {
                    ForEach(0..<numberOfQuestionArray.count) {
                        Text(self.numberOfQuestionArray[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("Questions")
                    .font(.title3)
            } // end of HStack
            
                Stepper("Range number in 2 to \(multiple)", value: $multiple, in: 2...9)
            StartButton(text: nameOfGame) {
                withAnimation(.easeOut) {
                    startGamePressed()
                }
            }
            if gameIsEnd {
                VStack {
                    Text("Last score \(score) in \(lastGame) possible")
                    Text(complitedString)
                        .foregroundColor(.blue)
                }
                    .font(.title)
            }
            
            if gameIsStart {
                HStack {
                    Text("Question \(currentQusetion) of \(numberOfQuestion)")
                    Spacer()
                    Text("\(numberOne) x \(numberTwo) = ?")
                        .bold()
                }
                HStack(spacing: 20) {
                    TextField("Your answer", text: $textAnswer)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    CheckAnswer(action: checkAnswer)
                }
                Text("Score: \(score)")
                    .font(.system(size: 35))
                    .foregroundColor(.blue)
            }
            
            Spacer()
        } // end of VStack
        .padding()
        
    }
    
    private func checkAnswer() {
        
        if textAnswer == String(numberTwo * numberOne) {
            score += 1
            numberOne = Int.random(in: 2...multiple)
            numberTwo = Int.random(in: 2...multiple)
        }
        numberOne = Int.random(in: 2...multiple)
        numberTwo = Int.random(in: 2...multiple)
        currentQusetion += 1
        textAnswer = ""
        if currentQusetion == numberOfQuestion + 1 {
            lastGame = numberOfQuestion
            gameIsStart.toggle()
            gameIsEnd = true
            if score < numberOfQuestion/2 + 1 {
                complitedString = "Need more practice"
            } else {
                complitedString = "You're good!"
            }
        }
    }
    
    private func startGamePressed() {
        currentQusetion = 1
        numberOne = Int.random(in: 2...multiple)
        numberTwo = Int.random(in: 2...multiple)
        if !gameIsStart {
            score = 0
            gameIsStart.toggle()
            gameIsEnd = false
            nameOfGame = "New game"
            switchQuestion()
        } else {
            gameIsStart.toggle()
            nameOfGame = "Start"
        }
    }
    
    private func switchQuestion() {
        switch selectedQuestions {
        case 0: numberOfQuestion = 5
        case 1: numberOfQuestion = 10
        case 2: numberOfQuestion = 15
        default: numberOfQuestion = 25
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
