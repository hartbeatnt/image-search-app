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
            SearchBarView(searchText: $searchText, searching: $searching) {
                print("**")
                if let url = URL(string: "https://api.imgur.com/3/gallery.json") {
                    let request = URLRequest(url: url)
                    request.setValue("Client-ID \(Secrets.clientId)", forHTTPHeaderField: "Authorization")
                }
            }
            RecentSearchesView(searchText: $searchText, recentSearches: $recentSearches)
        }
            .navigationTitle("Image Search")
            .toolbar {
                 if searching {
                     SearchCancelButtonView(searchText: $searchText, searching: $searching)
                 }
             }
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
