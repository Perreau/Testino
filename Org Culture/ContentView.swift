//
//  ContentView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                if !appState.emailSubmitted {
                    EmailInputView()
                } else if !appState.contactsUploaded {
                    ContactsUploadView()
                } else {
                    TabView {
                        PollView()
                            .tabItem {
                                Label("Poll", systemImage: "list.bullet")
                            }
                        
                        AttributeView()
                            .tabItem {
                                Label("Attributes", systemImage: "star.fill")
                            }
                    }
                }
            }
            .navigationTitle("Org Culture")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppState())
    }
}

