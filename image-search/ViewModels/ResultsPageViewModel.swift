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
        enum State { case loading, error, ready }
        @Published var state = State.ready
        @Published var urls = [URL]()
        func fetchData(query: String) {
            state = .loading
            cancellable = ImgurApi.search(query: query)
                .mapError { self.handle(error: $0) }
                .sink(receiveCompletion: { self.handle(completion: $0) },
                      receiveValue: { self.handle(response: $0) })
        }

        private var cancellable: AnyCancellable?

        private func handle(error: Error) -> Error {
            /*
             Ideally, for a real production app, we would inject a logging service into
             this class via dependency injection, and the logging service would handle
             this error. Since this is not a real production app, and I only have a week
             to build it, I am just going to print the error instead. #YOLO ¯\_(ツ)_/¯
             */
            print("error fetching data:", error)
            state = .error
            return error
        }

        private func handle(completion: Subscribers.Completion<ImgurApi.Publisher.Failure>) {
            state = .ready
        }

        private func handle(response: ImgurApi.Publisher.Output) {
            let urls = response.data
                .reduce([URL]()) { self.addResponseItem(into: $0, item: $1) }
                .filter { self.isDisplayableImage(url: $0) }
            self.urls = urls
            print(urls)
        }

        private func addResponseItem(into array: [URL], item: ImgurApi.ResponseItem) -> [URL] {
            switch item {
            case .image(let image):
                return array + [image.link]
            case .gallery(let gallery):
                return array + gallery.images.map(\.link)
            }
        }

        private func isDisplayableImage(url: URL) -> Bool {
            url.absoluteString.hasSuffix(".jpg")
                || url.absoluteString.hasSuffix(".jpeg")
                || url.absoluteString.hasSuffix(".png")
        }
    }
}
