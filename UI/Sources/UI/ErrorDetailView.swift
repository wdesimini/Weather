//
//  ErrorDetailView.swift
//  UI
//
//  Created by Wilson Desimini on 12/13/24.
//

import SwiftUI

public struct ErrorDetailView: View {
    private let description: String
    private let instruction: String

    public init(description: String, instruction: String) {
        self.description = description
        self.instruction = instruction
    }

    public var body: some View {
        VStack {
            Text(description)
                .font(.title)
                .padding()
            Text(instruction)
        }
    }
}

#Preview {
    ErrorDetailView(
        description: "No City Selected",
        instruction: "Please search for a city"
    )
}
