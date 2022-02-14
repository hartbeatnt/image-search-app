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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 40)), count: 3)) {
                ForEach($viewModel.images, id: \.self.link) { image in
                    let image = image.wrappedValue
                    PreviewImageView(url: image.link, width: image.width, height: image.height)
                        .onAppear { viewModel.maybeFetchMore(after: image) }
                }
            }
            if viewModel.state == .loading {
                ProgressView()
                    .padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
                
            }
            if viewModel.state == .error { ErrorView() }
        }
        .navigationTitle(query)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: onAppear)
    }

    private func onAppear() { viewModel.fetchData(query: query) }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsPageView(query: "")
    }
}
