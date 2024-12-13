//
//  SearchResultRow.swift
//  UI
//
//  Created by Wilson Desimini on 12/13/24.
//

import SwiftUI

public struct SearchResultRow: View {
    private let title: String
    private let subtitle: String?
    private let imageURL: URL?

    public init(title: String, subtitle: String? = nil, imageURL: URL? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                if let subtitle {
                    Text(subtitle)
                        .font(.title)
                }
            }
            Spacer()
            if let imageURL {
                AsyncImage(url: imageURL)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    SearchResultRow(
        title: "Portland, Oregon",
        subtitle: "31°",
        imageURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/296.png")
    )
}
