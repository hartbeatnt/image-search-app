//
//  RecentsListView.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

struct SuggestedSearchesView: View {
    @Binding var searchText: String
    @Binding var recents: [String]
    @Binding var suggested: [String]
    var didSelectSuggestion: (String) -> Void

    var body: some View {
        List {
            let filteredRecents = getFiltered(suggestions: recents)
            if !filteredRecents.isEmpty {
                Section(header: Text("Recent Searches")) {
                    ForEach(filteredRecents, id: \.self) { suggestion in
                        NavigationLink(destination: ResultsPageView(query: searchText)) {
                            Text(suggestion)
                                .gesture(TapGesture(count: 1).onEnded {
                                    didSelectSuggestion(suggestion)
                                })
                        }
                    }
                }
            }

            let filteredPopular = getFiltered(suggestions: suggested)
            if !filteredPopular.isEmpty {
                Section(header: Text("Popular Searches")) {
                    ForEach(getFiltered(suggestions: suggested), id: \.self) { suggestion in
                        NavigationLink(destination: ResultsPageView(query: searchText)) {
                            Text(suggestion)
                                .gesture(TapGesture(count: 1).onEnded {
                                    didSelectSuggestion(suggestion)
                                })
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .gesture(TapGesture(count: 1).onEnded { _ in
            UIApplication.shared.dismissKeyboard()
        })
    }

    private func getFiltered(suggestions: [String]) -> [String] {
        searchText.isEmpty
            ? suggestions
            : suggestions.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
    }
}

struct SuggestedSearchesView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var recentSearches = [String]()
    @State static var suggestedSearches = [String]()
    static var previews: some View {
        SuggestedSearchesView(searchText: $searchText,
                              recents: $recentSearches,
                              suggested: $suggestedSearches,
                              didSelectSuggestion: { _ in })
    }
}
