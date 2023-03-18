//
//  Utilities.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import Foundation

public func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

public func extractDomain(from email: String) -> String {
    let components = email.split(separator: "@")
    guard let domain = components.last else { return "" }
    return String(domain)
}
