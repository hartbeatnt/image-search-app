//
//  RecentsListView.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

struct RecentSearchesView: View {
    @Binding var searchText: String
    @Binding var recentSearches: [String]

    var body: some View {
        List {
            Section(header: Text("Recent Searches")) {
                let filteredRecents = searchText.isEmpty
                    ? recentSearches
                    : recentSearches.filter {
                        $0.lowercased().contains(searchText.lowercased())
                    }
                ForEach(filteredRecents, id: \.self) { query in
                    NavigationLink(destination: ResultsPageView(query: searchText)) {
                        Text(query)
                    }
                }
            }
        }
            .listStyle(GroupedListStyle())
            .gesture(TapGesture(count: 1).onEnded { _ in
                UIApplication.shared.dismissKeyboard()
            })
    }
}

struct RecentSearchesView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var recentSearches = [String]()
    static var previews: some View {
        RecentSearchesView(searchText: $searchText, recentSearches: $recentSearches)
    }
}
