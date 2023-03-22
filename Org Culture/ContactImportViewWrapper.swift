//
//  ContactImportViewWrapper.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/21/23.
//

import SwiftUI
import ContactsUI

struct ContactImportViewWrapper: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var contacts: [CNContact]
    @Binding var emails: [String]
    @Binding var phoneNumbers: [String]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactImportViewWrapper>) -> UINavigationController {
        let navController = UINavigationController()
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        navController.setViewControllers([contactPicker], animated: true)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<ContactImportViewWrapper>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactImportViewWrapper

        init(_ parent: ContactImportViewWrapper) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            parent.contacts = contacts
            parent.phoneNumbers = contacts.compactMap { $0.phoneNumbers.first?.value.stringValue }
            parent.emails = contacts.compactMap { $0.emailAddresses.first?.value as String? }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

