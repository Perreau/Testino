//
//  ContactsUploadView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI
import Contacts

struct User: Identifiable, Equatable {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

class AppState: ObservableObject {
    @Published var colleagues: [User] = []
    @Published var contacts: [User] = []
    
    func addPollAnswer(answerId: UUID, question: String) {
        guard let colleague = colleagues.first(where: { $0.id == answerId }) else { return }
        colleague.answers.append(question)
    }
}

struct ContactImportViewWrapper: UIViewControllerRepresentable {
    @Binding var contacts: [CNContact]
    @Binding var emails: [String]
    @Binding var phoneNumbers: [String]
    
    func makeUIViewController(context: Context) -> ContactImportViewController {
        ContactImportViewController(contacts: $contacts, emails: $emails, phoneNumbers: $phoneNumbers)
    }
    
    func updateUIViewController(_ uiViewController: ContactImportViewController, context: Context) {
    }
}

struct ContactsUploadView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showingImportView = false
    @State private var selection = Set<User>()
    @State private var contacts: [CNContact] = []
    @State private var emails: [String] = []
    @State private var phoneNumbers: [String] = []
    
    private let maxContacts = 4
    
    private var isValidSelection: Bool {
        selection.count >= maxContacts || (contacts.count + emails.count >= maxContacts)
    }
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach(appState.contacts) { contact in
                    let fullName = "\(contact.firstName ?? "") \(contact.lastName)"
                    let isSelected = selection.contains { $0.id == contact.id }
                    
                    Button(action: {
                        if isSelected {
                            selection.remove(contact)
                        } else {
                            selection.insert(contact)
                        }
                    }) {
                        HStack {
                            Text(fullName)
                                .fontWeight(isSelected ? .bold : .regular)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                ForEach(contacts, id: \.self) { contact in
                    let fullName = "\(contact.givenName) \(contact.familyName)"
                    let isSelected = selection.contains(where: { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue })
                    
                    Button(action: {
                        if isSelected {
                            if let index = selection.firstIndex(where: { $0.phoneNumber == contact.phoneNumbers.first?.value.stringValue }) {
                                selection.remove(at: index)
                            }
                        } else {
                            let user = User(id: UUID(),
                                            email: "",
                                            firstName: contact.givenName,
                                            lastName: contact.familyName,
                                            phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
                            selection.insert(user)
                        }
                    }) {
                        HStack {
                            Text(fullName)
                                .fontWeight(isSelected ? .bold : .regular)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                ForEach(emails, id: \.self) { email in
                    let isSelected = selection.contains(where: { $0.email == email })
                    
                    Button(action: {
                        if isSelected {
