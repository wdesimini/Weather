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
            } else {
                HomeSearchResultsView()
                    .environment(viewModel)
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

struct HomeSearchResultsView: View {
    @Environment(\.dismissSearch)
    private var dismissSearch
    @Environment(HomeViewModel.self)
    private var viewModel

    var body: some View {
        if viewModel.searchResults.isEmpty {
            VStack {
                Text("No City Selected")
                    .font(.title)
                    .padding()
                Text("Please search for a city")
            }
        } else {
            List(viewModel.searchResults) { result in
                Text("\(result.name), \(result.region), \(result.country)").onTapGesture {
                    dismissSearch()
                    onLocationSelect(result)
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
