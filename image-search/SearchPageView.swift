//
//  SearchView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI
import Combine

var cancellable: AnyCancellable?

struct SearchPageView: View {
    @State private var searchText = ""
    @State private var searching = false
    @State private var didCompleteSearch = false

    @State private var recentSearches = [
        "car",
        "anteater",
        "diamonds",
        "food",
        "elephant",
        "puppies",
        "memes"
    ]

    var body: some View {
        VStack {
            NavigationLink(destination: ResultsPageView(query: searchText), isActive: $didCompleteSearch) {
                EmptyView()
            }
            SearchBarView(searchText: $searchText, searching: $searching) {
                didCompleteSearch = true
            }
            Text("Type a phrase into the search bar, or select a suggested search below")
            SuggestedSearchesView(searchText: $searchText, recentSearches: $recentSearches) { suggestion in
                searchText = suggestion
                didCompleteSearch = true
            }
        }
            .navigationTitle("Image Search")
            .onAppear(perform: onAppear)
            .toolbar(content: maybeAddCancelButton)
    }

    private func onAppear() {
        searchText = ""
        searching = false
        didCompleteSearch = false
    }

    private func maybeAddCancelButton() -> SearchCancelButtonView? {
        searching
            ? SearchCancelButtonView(searchText: $searchText, searching: $searching)
            : nil
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
