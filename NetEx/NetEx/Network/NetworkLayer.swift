//
//  NetworkLayer.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/30.
//

import UIKit

// https://itunes.apple.com
// /search
// /article
// path



/*


 media
 movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
 */

enum MyError: Error, CustomStringConvertible {
    case badURL
    case badCasting
    case badStatusCode

    var description: String {
        switch self {
        case .badURL:
            return "BAD URL !"
        case .badCasting:
            return "BAD CASTING !"
        case .badStatusCode:
            return "BAD STATUS CODE !"
        }
    }
}

class NetworkLayer {

    static func requestMediaAsync(mediaType: MediaType) async throws -> MovieModel {
        let media = URLQueryItem(name: "media", value: mediaType.queryValue)
        let term = URLQueryItem(name: "term", value: mediaType.queryValue)

        let querys = [term, media]
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")

        urlComponents?.queryItems = querys

        guard let url = urlComponents?.url else {
            throw MyError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw MyError.badCasting }
        guard (200..<300).contains(httpResponse.statusCode) else { throw MyError.badStatusCode }
        let decodedModel = try JSONDecoder().decode(MovieModel.self, from: data)
        return decodedModel
    }

    static func request(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()

    }

    static func request(mediaType: MediaType, completion: @escaping (MovieModel) -> Void) {
        let media = URLQueryItem(name: "media", value: mediaType.queryValue)
        let term = URLQueryItem(name: "term", value: mediaType.queryValue)

        let querys = [term, media]

        var urlComponents = URLComponents(string: "http//itunes.apple.com/search")

        urlComponents?.queryItems = querys

        guard let url = urlComponents?.url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let data {
                do {
                    let movieModel = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(movieModel)
                } catch {
                    print("decode error:", error)
                }
            }
        }
        task.resume()


    }
}


