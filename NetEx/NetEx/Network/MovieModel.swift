//
//  MovieModel.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/30.
//

import Foundation


struct MovieModel: Decodable {
    let resultCount: Int
    let results: [MovieResult]

}

struct MovieResult: Decodable {
    let trackName: String?
    let previewUrl: String?
    let artworkUrl: String?
    let releaseDate: String?
    let shortDescription: String?
    let longDescription: String?

    enum CodingKeys: String, CodingKey {
        case trackName
        case previewUrl
        case artworkUrl = "artworkUrl100"
        case releaseDate
        case shortDescription
        case longDescription
    }
}
