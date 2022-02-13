//
//  Networking.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//
import Foundation
import Combine

enum ImgurApi {
    typealias Publisher = AnyPublisher<Response, Error>
    static let apiClient = Networking()
    static let baseUrl = "https://api.imgur.com/3/gallery/search/top"

    static func search(query: String, page: Int = 0) -> Publisher {
        guard
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: "\(baseUrl)/\(page)?q=\(query)") else {
            fatalError("invalid url")
        }
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Secrets.clientId)", forHTTPHeaderField: "Authorization")
        return apiClient.request(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

extension ImgurApi {
    struct Response: Decodable {
        let data: [ResponseItem]
        let success: Bool
        let status: Int
    }
    
    struct Gallery: Decodable {
        let images: [Image]
    }

    struct Image: Decodable {
        let link: URL
    }

    enum ResponseItem: Decodable {
        case gallery(Gallery)
        case image(Image)

        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer()

            if let gallery = try? value.decode(Gallery.self) {
                self = .gallery(gallery)
                return
            } else if let image = try? value.decode(Image.self) {
                self = .image(image)
                return
            }

            fatalError()
        }
    }
}

