//
//  SearchView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    let recentSearches = [
        "car",
        "diamonds",
        "food"
    ]
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText)
            List {
                Section(header: Text("Recent Searches")) {
                    ForEach(recentSearches, id: \.self) { query in
                        Text(query)
                    }
                }
            }
                .listStyle(GroupedListStyle())
        }
            .navigationTitle("Image Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
