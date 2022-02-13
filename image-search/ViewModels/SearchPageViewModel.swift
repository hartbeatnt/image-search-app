//
//  SearchPageViewModel.swift
//  image-search
//
//  Created by Nate Hart on 2/13/22.
//

import Combine
import Foundation

extension SearchPageView {
    @MainActor class ViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var searching = false
        @Published var didCompleteSearch = false
        @Published var suggestedSearches = ViewModel.suggestedSearches
        
        func onAppear() {
            searchText = ""
            searching = false
            didCompleteSearch = false
        }

        func onSelected(suggestion: String) {
            searchText = suggestion
            onSubmit()
        }

        func onSubmit() {
            didCompleteSearch = true
        }
    }
}

extension SearchPageView.ViewModel {
    private static let suggestedSearches = [
        "car",
        "anteater",
        "diamonds",
        "food",
        "elephant",
        "puppies",
        "memes"
    ]
}
