//
//  File.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id = UUID()
    let email: String
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    var attributes: [String: Int] = [:]

    init(id: UUID = UUID(), email: String, firstName: String? = nil, lastName: String? = nil, phoneNumber: String? = nil, attributes: [String: Int] = [:]) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.attributes = attributes
    }
}

