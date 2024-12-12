//
//  WeatherApp.swift
//  Weather
//
//  Created by Wilson Desimini on 12/12/24.
//

import SwiftUI
import Home

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

struct AppView: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}
