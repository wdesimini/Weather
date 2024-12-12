//
//  HomeView.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import SwiftUI

public struct HomeView: View {
    @State
    private var searchText = ""

    public init() {
    }

    public var body: some View {
        Text("(Home View)")
            .searchable(text: $searchText)
    }
}

#Preview {
    HomeView()
}
