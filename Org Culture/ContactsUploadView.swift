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
    @State private var newEmail: String = ""

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

    private func addEmail() {
        if newEmail.isEmpty {
            showAlert = true
            return
        }

        let colleague = User(email: newEmail)
        appState.currentUser?.addColleague(colleague)
        selectedContacts.append(colleague)
        newEmail = ""
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

            TextField("Add email address", text: $newEmail)
                .padding()
                .background(Color(white: 0.9))
                .cornerRadius(8)
                .padding()

            Button(action: {
                addEmail()
            }) {
                Text("Add Email")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Modify the Skip button to be visible only if there are at least four contacts
            if selectedContacts.count >= 4 {
                Button(action: {
                    appState.contactsUploaded = true
                }) {
                    Text("Skip")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
    }
}
