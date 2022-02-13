//
//  ResultView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI

struct ResultsPageView: View {
    var query: String
    @StateObject private var viewModel = ViewModel()
    
    init(query: String) {
        self.query = query
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid) {
                ForEach($viewModel.urls, id: \.self) {
                    PreviewImageView(url: $0.wrappedValue)
                }
            }
            if viewModel.state == .loading {
                ProgressView()
            }
        }
        
        .navigationTitle(query)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: onAppear)
    }

    private func onAppear() { viewModel.fetchData(query: query) }

    private var threeColumnGrid = [GridItem(), GridItem(), GridItem()]
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsPageView(query: "")
    }
}
