//
//  PollView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

struct PollView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    
    let questions = [
        "Most collaborative",
        "Best listener",
        "Most innovative",
        "Best problem solver",
        "Most adaptable",
        "Best at time management",
        "Strongest work ethic",
        "Most reliable",
        "Best communicator",
        "Most detail-oriented",
        "Strongest leadership",
        "Best at conflict resolution",
        "Most helpful",
        "Best mentor",
        "Most positive attitude",
        "Most knowledgeable",
        "Best team player",
        "Most proactive",
        "Best critical thinker",
        "Best decision maker",
        "Strongest negotiation skills",
        "Most efficient",
        "Most organized",
        "Best at delegating",
        "Strongest networking skills",
        "Best at multitasking",
        "Most supportive",
        "Most customer-focused",
        "Best at motivating others",
        "Best at meeting deadlines"
    ]
    
    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
        }
        selectedAnswer = nil
    }
    
    var body: some View {
        VStack {
            Text("Question: \(questions[currentQuestionIndex])")
                .font(.largeTitle)
                .padding()
            
            let colleagues = Array(appState.currentUser?.attributes.keys.shuffled().prefix(4) ?? [])
            ForEach(colleagues, id: \.self) { colleague in
                Button(action: {
                    selectedAnswer = colleague
                }) {
                    Text(colleague)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedAnswer == colleague ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                if let answer = selectedAnswer {
                    appState.currentUser?.attributes[answer, default: 0] += 1
                    nextQuestion()
                }
            }) {
                Text("Submit")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedAnswer == nil)
        }
    }
}
