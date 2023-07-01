//
//  NetworkLayer.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/30.
//

import UIKit

// https://itunes.apple.com/search?media=movie&term=movie

/*


 media
 movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
 */

class NetworkLayer {

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

        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")

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


