//
//  ContactImportView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/21/23.
//

import SwiftUI
import ContactsUI

struct ContactImportView: UIViewControllerRepresentable {
    @EnvironmentObject var appState: AppState
    @Binding var contacts: [User]
    @Binding var emails: [String]
    @Binding var phoneNumbers: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(showingImportView: $appState.wrappedValue.showingImportView,
                    contacts: $contacts,
                    emails: $emails,
                    phoneNumbers: $phoneNumbers)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactImportView>) -> CNContactPickerViewController {
        let viewController = CNContactPickerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: UIViewControllerRepresentableContext<ContactImportView>) {
    }
}

class Coordinator: NSObject, CNContactPickerDelegate {
    @Binding var showingImportView: Bool
    var contacts: Binding<[User]>
    var emails: Binding<[String]>
    var phoneNumbers: Binding<[String]>
    
    init(showingImportView: Binding<Bool>, contacts: Binding<[User]>, emails: Binding<[String]>, phoneNumbers: Binding<[String]>) {
        _showingImportView = showingImportView
        self.contacts = contacts
        self.emails = emails
        self.phoneNumbers = phoneNumbers
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for contact in contacts {
            let firstName = contact.givenName
            let lastName = contact.familyName
            
            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                let user = User(id: UUID(),
                                email: "",
                                firstName: firstName,
                                lastName: lastName,
                                phoneNumber: phoneNumber)
                self.contacts.wrappedValue.append(user)
                self.phoneNumbers.wrappedValue.append(phoneNumber)
            }
            
            if let email = contact.emailAddresses.first?.value as String? {
                let user = User(id: UUID(),
                                email: email,
                                firstName: firstName,
                                lastName: lastName,
                                phoneNumber: "")
                self.contacts.wrappedValue.append(user)
                self.emails.wrappedValue.append(email)
            }
        }
        showingImportView = false
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        showingImportView = false
    }
}
