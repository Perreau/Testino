//
//  AttributeView.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

struct AttributeView: View {
    @EnvironmentObject var appState: AppState
    private let minimumResponses = 10
    
    var sortedAttributes: [(key: String, value: Int)] {
        let attributes = appState.currentUser?.attributes ?? [:]
        return attributes.sorted { $0.value > $1.value }
    }
    
    var enoughResponses: Bool {
        let totalResponses = appState.currentUser?.attributes.values.reduce(0, +) ?? 0
        return totalResponses >= minimumResponses
    }
    
    var body: some View {
        VStack {
            if enoughResponses {
                List(sortedAttributes, id: \.key) { attribute in
                    HStack {
                        Text(attribute.key)
                            .font(.headline)
                        Spacer()
                        Text("\(attribute.value)")
                            .font(.subheadline)
                    }
                }
            } else {
                VStack {
                    Text("Waiting for more respondents, invite your colleagues")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Minimum responses required: \(minimumResponses)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }
}
