//
//  RecentsListView.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

struct SuggestedSearchesView: View {
    @Binding var searchText: String
    @Binding var recentSearches: [String]
    var didSelectSuggestion: (String) -> Void

    var body: some View {
        List {
            Section(header: Text("Suggested Searches")) {
                ForEach(getFilteredRecents(), id: \.self) { suggestion in
                    NavigationLink(destination: ResultsPageView(query: searchText)) {
                        Text(suggestion)
                            .gesture(TapGesture(count: 1).onEnded {
                                didSelectSuggestion(suggestion)
                            })
                    }
                }
            }
        }
            .listStyle(GroupedListStyle())
            .gesture(TapGesture(count: 1).onEnded { _ in
                UIApplication.shared.dismissKeyboard()
            })
    }

    private func getFilteredRecents() -> [String] {
        searchText.isEmpty
            ? recentSearches
            : recentSearches.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
    }
}

struct SuggestedSearchesView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var recentSearches = [String]()
    static var previews: some View {
        SuggestedSearchesView(searchText: $searchText, recentSearches: $recentSearches) { _ in }
    }
}
