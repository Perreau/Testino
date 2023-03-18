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

    private func uploadContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            try store.enumerateContacts(with: request) { (contact, _) in
                if let emailAddress = contact.emailAddresses.first?.value as String? {
                    let colleague = User(email: emailAddress)
                    appState.currentUser?.addColleague(colleague)
                }
            }
            appState.contactsUploaded = true
        } catch {
            print("Error fetching contacts")
            showAlert = true
        }
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
        }
        .padding()
    }
}
