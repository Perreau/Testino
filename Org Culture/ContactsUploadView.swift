//
//  ContactsUploadView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI
import Contacts

struct ContactsUploadView: View {
    @EnvironmentObject var appState: AppState
    @State private var showAlert: Bool = false
    @State private var selectedContacts: [User] = []
    @State private var newEmails: [String] = Array(repeating: "", count: 4)

    private func uploadContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor]

        let request = CNContactFetchRequest(keysToFetch: keysToFetch)

        do {
            try store.enumerateContacts(with: request) { (contact, _) in
                if let emailAddress = contact.emailAddresses.first?.value as String? {
                    let colleague = User(email: emailAddress)
                    appState.currentUser?.addColleague(colleague)
                    selectedContacts.append(colleague)
                }
            }
            appState.contactsUploaded = true
        } catch {
            print("Error fetching contacts")
            showAlert = true
        }
    }

    private func addEmails() {
        for email in newEmails {
            if !email.isEmpty {
                let colleague = User(email: email)
                appState.currentUser?.addColleague(colleague)
                selectedContacts.append(colleague)
            }
        }
        appState.contactsUploaded = true
    }

    var body: some View {
        VStack {
            Text("Upload your contacts:")
                .font(.title)
                .padding()

            Button(action: {
                uploadContacts()
            }) {
                Text("Upload")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("There was an error uploading your contacts. Please try again."), dismissButton: .default(Text("OK")))
            }

            ForEach(0..<max(0, 4 - selectedContacts.count), id: \.self) { index in
                TextField("Add email address", text: $newEmails[index])
                    .padding()
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Button(action: {
                addEmails()
            }) {
                Text("Submit")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedContacts.count + newEmails.filter { !$0.isEmpty }.count >= 4 ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedContacts.count + newEmails.filter { !$0.isEmpty }.count < 4)
        }
        .padding()
    }
}
