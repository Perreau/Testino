//
//  ColleagueButtonStyle.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/21/23.
//

import SwiftUI

struct ColleagueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(15)
    }
}
