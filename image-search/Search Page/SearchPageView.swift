//
//  SearchView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI
import Combine

struct SearchPageView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            SearchBarView(
                searchText: $viewModel.searchText,
                searching: $viewModel.searching,
                submitSearch: { viewModel.onSubmit() }
            )
            Text("Type a phrase into the search bar, or select a suggested search below")
            SuggestedSearchesView(
                searchText: $viewModel.searchText,
                recentSearches: $viewModel.suggestedSearches,
                didSelectSuggestion: { viewModel.onSelected(suggestion: $0) }
            )
            NavigationLink(
                destination: ResultsPageView(query: viewModel.searchText),
                isActive: $viewModel.didCompleteSearch
            ) { EmptyView() }
        }
        .navigationTitle("Image Search")
        .onAppear { viewModel.onAppear() }
        .toolbar { maybeAddCancelButton() }
    }

    private func maybeAddCancelButton() -> SearchCancelButtonView? {
        viewModel.searching
            ? SearchCancelButtonView(searchText: $viewModel.searchText, searching: $viewModel.searching)
            : nil
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
