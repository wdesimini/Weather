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
                CurrentWeatherDetailView(viewModel: .init(weather: weather))
            } else if let location = viewModel.location {
                Text("No weather for \(location)")
            } else {
                HomeSearchResultsView()
                    .environment(viewModel)
            }
        }
        .onAppear(perform: onAppear)
        .searchable(text: $searchText, prompt: Text("Search Location"))
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

struct HomeSearchResultsView: View {
    @Environment(\.dismissSearch)
    private var dismissSearch
    @Environment(\.isSearching)
    private var isSearching
    @Environment(HomeViewModel.self)
    private var viewModel

    var body: some View {
        if !isSearching {
            ErrorDetailView(
                description: "No City Selected",
                instruction: "Please search for a city"
            )
        } else {
            ScrollView {
                ForEach(viewModel.searchResults) { result in
#warning("TODO: Add location weather here?")
                    SearchResultRow(title: "\(result.name), \(result.region)")
                        .onTapGesture {
                            dismissSearch()
                            onLocationSelect(result)
                        }
                }
            }
        }
    }

    private func onLocationSelect(_ location: LocationSearchResult) {
        Task {
            await viewModel.selectLocation(location)
        }
    }
}
