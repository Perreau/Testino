//
//  ContactsUploadView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI
import ContactsUI

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
                    let fullName = "\(contact.firstName) \(contact.lastName)"
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
                            if let index = selection.firstIndex(where: { $0.email == email }) {
                                selection.remove(at: index)
                            }
                        } else {
                            let user = User(id: UUID(),
                                            email: email,
                                            firstName: "",
                                            lastName: "",
                                            phoneNumber: "")
                            selection.insert(user)
                        }
                    }) {
                        HStack {
                            Text(email)
                                .fontWeight(isSelected ? .bold : .regular)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle("Upload Contacts")
            .navigationBarItems(trailing: Button("Import") {
                self.showingImportView = true
            })
            .sheet(isPresented: $showingImportView) {
                ContactImportViewWrapper(contacts: self.$contacts, emails: self.$emails, phoneNumbers: self.$phoneNumbers)
            }
            
            Button(action: {
                appState.colleagues.append(contentsOf: selection)
                selection.removeAll()
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
            }}}}

