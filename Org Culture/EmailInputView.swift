//
//  EmailInputView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

struct EmailInputView: View {
    @EnvironmentObject var appState: AppState
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    
    private func submitEmail() {
        if isValidEmail(email) {
            appState.emailSubmitted = true
            appState.currentUser = User(email: email)
        } else {
            showAlert = true
        }
    }
    
    var body: some View {
        VStack {
            Text("Enter your email address:")
                .font(.title)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                submitEmail()
            }) {
                Text("Submit")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Email"), message: Text("Please enter a valid email address."), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

