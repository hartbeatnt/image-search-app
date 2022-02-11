//
//  SearchView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI

struct SearchPageView: View {
    @State private var searchText = ""
    @State private var searching = false
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
            SearchBarView(searchText: $searchText, searching: $searching)
            RecentSearchesView(searchText: $searchText, recentSearches: $recentSearches)
        }
            .navigationTitle("Image Search")
            .toolbar {
                 if searching {
                     CancelButtonView(searchText: $searchText, searching: $searching)
                 }
             }
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
