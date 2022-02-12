//
//  SearchBarView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    let submitSearch: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { isSearching in
                    if isSearching {
                        withAnimation { searching = true }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                        submitSearch()
                    }
                }
                    .foregroundColor(.white)
            }
                .padding(.leading, 13)
         }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var searching = false
    static var previews: some View {
        SearchBarView(searchText: $searchText, searching: $searching) { }
    }
}
