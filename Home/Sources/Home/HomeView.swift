//
//  HomeView.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import SwiftUI
import Models
import UI

public struct HomeView: View {
    @State
    private var searchText = ""
    @State
    private var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel = .init()) {
        _viewModel = State(initialValue: viewModel)
    }

    private var errorBinding: Binding<Error?> {
        Binding {
            viewModel.error
        } set: { error in
            viewModel.handleError(error)
        }
    }

    public var body: some View {
        Group {
            if viewModel.loading {
                ProgressView()
            } else if let weather = viewModel.weather {
                Text("\(weather)")
            } else if let location = viewModel.location {
                Text("No weather for \(location)")
            } else if viewModel.location == nil {
                VStack {
                    Text("No City Selected")
                        .font(.title)
                        .padding()
                    Text("Please search for a city")
                }
            } else {
                LazyVStack {
                    ForEach(viewModel.searchResults) { result in
                        Text("\(result)")
                    }
                }
            }
        }
        .onAppear(perform: onAppear)
        .searchable(text: $searchText)
        .disabled(viewModel.loading)
        .onSubmit(of: .search, onSearch)
        .errorAlert(error: errorBinding)
    }

    private func onAppear() {
        Task {
            await viewModel.onAppear()
        }
    }

    private func onSearch() {
        Task {
            await viewModel.search(for: searchText)
        }
    }
}

// MARK: - Previews

private final class PreviewHomeService: HomeServiceProtocol {
    func loadSelectedLocation() async throws -> String? {
        "Portland, OR"
    }

    func searchCities(query: String) async throws -> [LocationSearchResult] {
        []
    }

    func fetchWeather(for location: String) async throws -> CurrentWeather? {
        nil
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel(service: PreviewHomeService()))
    }
}
