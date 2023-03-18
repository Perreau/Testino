//
//  File.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import Foundation

class User: Identifiable, ObservableObject {
    let id = UUID()
    var email: String
    @Published var colleagues: [User] = []
    @Published var attributes: [String: Int] = [:]

    init(email: String) {
        self.email = email
    }

    func addColleague(_ colleague: User) {
        colleagues.append(colleague)
    }
}
