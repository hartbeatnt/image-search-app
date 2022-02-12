//
//  ResultsPageViewModel.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import Combine
import Foundation

extension ResultsPageView {
    @MainActor class ViewModel: ObservableObject {
        func fetchData(query: String) {
            cancellable = ImgurApi.search(query: query)
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

        private var cancellable: AnyCancellable?
    }
}
