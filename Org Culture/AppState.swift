//
//  AppState.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var emailSubmitted: Bool = false
    @Published var contactsUploaded: Bool = false
    
    // List of 30 questions
    let questions: [String] = [
        "Who is the most creative?",
        "Who is the best listener?",
        "Who is the most adaptable?",
        "Who is the most collaborative?",
        "Who is the best at problem-solving?",
        "Who is the most detail-oriented?",
        "Who is the best at time management?",
        "Who is the most efficient?",
        "Who is the best at conflict resolution?",
        "Who has the most positive attitude?",
        "Who is the best at delegating tasks?",
        "Who is the most organized?",
        "Who is the most reliable?",
        "Who is the best at multitasking?",
        "Who is the best at handling stress?",
        "Who is the best at making decisions?",
        "Who has the strongest work ethic?",
        "Who is the best at meeting deadlines?",
        "Who is the best at planning and executing projects?",
        "Who has the best communication skills?",
        "Who is the best at building relationships?",
        "Who is the best at giving presentations?",
        "Who has the strongest technical skills?",
        "Who is the best at motivating others?",
        "Who is the best at setting goals and achieving them?",
        "Who is the best at providing feedback?",
        "Who is the best at taking initiative?",
        "Who is the best at staying focused?",
        "Who is the best at staying up-to-date with industry trends?",
        "Who is the best at learning new skills?",
    ]
}

