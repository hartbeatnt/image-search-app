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

        @Published var state = State.ready
        @Published var images = [Image]()
        var query = ""
        var page = 0

        func fetchData(query: String) {
            self.query = query
            state = .loading
            cancellable = ImgurApi.search(query: query, page: page)
                .mapError { self.handle(error: $0) }
                .sink(receiveCompletion: { self.handle(completion: $0) },
                      receiveValue: { self.handle(response: $0) })
        }

        func maybeFetchMore(after image: Image) {
            if image == images.last {
                page += 1
                fetchData(query: query)
            }
        }

        private var cancellable: AnyCancellable?
    }
}

extension ResultsPageView.ViewModel {
    typealias Image = ImgurApi.Image
    enum State { case loading, error, ready }

    private func handle(error: Error) -> Error {
        /*
         Ideally, for a real production app, we would inject a logging service into
         this class via dependency injection, and the logging service would handle
         this error. Since this is not a real production app, and I only have a week
         to build it, I am just going to print the error instead. #YOLO ¯\_(ツ)_/¯
         */
        print("error fetching data:", error)
        return error
    }

    private func handle(completion: Subscribers.Completion<ImgurApi.Publisher.Failure>) {
        switch completion {
        case .finished: state = .ready
        case .failure: state = .error
        }
    }

    private func handle(response: ImgurApi.Publisher.Output) {
        let images = response.data
            .reduce([Image]()) { self.addResponseItem(into: $0, item: $1) }
            .filter { self.isDisplayableImage(url: $0.link) }
        self.images.append(contentsOf: images)
    }

    private func addResponseItem(into array: [Image], item: ImgurApi.ResponseItem) -> [Image] {
        switch item {
        case .image(let image):
            return array + [image]
        case .gallery(let gallery):
            return array + gallery.images
        }
    }

    private func isDisplayableImage(url: URL) -> Bool {
        // this could be more robust, perhaps by using a regex,
        // but is good enough for now as-is
        url.absoluteString.hasSuffix(".jpg")
            || url.absoluteString.hasSuffix(".jpeg")
            || url.absoluteString.hasSuffix(".png")
    }
}
