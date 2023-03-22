//
//  PollView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

struct PollView: View {
    @EnvironmentObject var appState: AppState
    
    @State var selectedAnswer: UUID?
    @State var currentQuestion = 0
    
    var questions = [
        "Most collaborative",
        "Best listener",
        "Most reliable",
        "Most innovative",
        "Best problem solver",
        "Most adaptable",
        "Most supportive",
        "Best communicator",
        "Best team player",
        "Most positive attitude",
        "Most organized",
        "Most detail-oriented",
        "Best decision maker",
        "Most resilient",
        "Most proactive",
        "Best at managing stress",
        "Best mentor",
        "Most efficient",
        "Most accountable",
        "Best conflict resolver",
        "Most empathetic",
        "Best at delegating tasks",
        "Most punctual",
        "Best at giving feedback",
        "Most strategic thinker",
        "Best at building relationships",
        "Most resourceful",
        "Best work ethic",
        "Most consistent",
        "Best at motivating others"
    ]
    
    var body: some View {
        VStack {
            Text("Question \(currentQuestion + 1) of \(questions.count): \(questions[currentQuestion])")
                .font(.headline)
                .padding(.bottom, 20)
            
            ForEach(appState.colleagues) { colleague in
                Button(action: {
                    selectedAnswer = colleague.id
                }) {
                    Text("\(colleague.firstName) \(colleague.lastName)")
                }
                .buttonStyle(ColleagueButtonStyle())
                .disabled(selectedAnswer != nil)
            }
            
            if selectedAnswer != nil {
                Button("Next question") {
                    if currentQuestion == questions.count - 1 {
                        appState.addPollAnswer(answerId: selectedAnswer!, question: questions[currentQuestion])
                        selectedAnswer = nil
                        currentQuestion = 0
                    } else {
                        appState.addPollAnswer(answerId: selectedAnswer!, question: questions[currentQuestion])
                        selectedAnswer = nil
                        currentQuestion += 1
                    }
                }
                .buttonStyle(CustomButtonStyle(foregroundColor: .green))
            }
        }
        .padding()
        .navigationBarTitle("Poll")
    }
}

struct PollView_Previews: PreviewProvider {
    static var previews: some View {
        PollView()
            .environmentObject(AppState())
    }
}
