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
                cancellable = ImgurApi.search(query: searchText)
                    .mapError({ (error) -> Error in
                        print(error)
                        return error
                    })
                    .sink(receiveCompletion: { _ in },
                          receiveValue: { response in
                        let urls = response.data.reduce([]) {
                            switch $1 {
                            case .image(let image):
                                return $0 + [image.link]
                            case .gallery(let gallery):
                                return $0 + gallery.images.map(\.link)
                            }
                        }
                        print(urls)
                    })
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
