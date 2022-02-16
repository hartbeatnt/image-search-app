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
        @Published var recentSearches = [String]()
        
        func onAppear() {
            searchText = ""
            searching = false
            didCompleteSearch = false
            if let recentSearches = fileService.readJSON(fromFile: File.recents.rawValue) {
                self.recentSearches = recentSearches
                suggestedSearches = Array(Set(suggestedSearches).subtracting(recentSearches))
            }
        }

        func onSelected(suggestion: String) {
            searchText = suggestion
            onSubmit()
        }

        func onSubmit() {
            didCompleteSearch = true
            recentSearches = ([searchText] + recentSearches.filter { $0 != searchText })
                .prefix(10)
                .map{ String($0) }
            suggestedSearches = Array(Set(ViewModel.suggestedSearches).subtracting(recentSearches))
            fileService.writeJSON(data: recentSearches, toFile: File.recents.rawValue)
        }

        private let fileService = FileService()
    }
}

extension SearchPageView.ViewModel {
    enum File: String {
        case recents = "recent_searches_data"
    }

    private static let suggestedSearches = [
        "Car",
        "Anteater",
        "Diamonds",
        "Food",
        "Elephant",
        "Puppies",
        "Memes"
    ]
}
