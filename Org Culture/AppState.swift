//
//  AppState.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var contacts: [User] = []
    @Published var colleagues: [User] = []
    @Published var currentUser: User?
    @Published var emailSubmitted: Bool = false
    @Published var contactsUploaded: Bool = false

    // List of 30 questions
    let questions: [String] = [
        // ... (the list of questions you provided)
    ]

    func addPollAnswer(answerId: UUID, question: String) {
        // Add the logic to add poll answers
    }
}
