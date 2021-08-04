//
//  Beer.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/04.
//

import Foundation

// MARK: - Beer
struct Beer: Codable {
    let id: Int
    let name, brewery: String
    let abv: Double
    let country, beerStyle: String
    let aroma: [String]
    let thumbnailImage: String
    let rateAvg, reviewCount: Int
    let favoriteFlag: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, brewery, abv, country
        case beerStyle = "beer_style"
        case aroma
        case thumbnailImage = "thumbnail_image"
        case rateAvg = "rate_avg"
        case reviewCount = "review_count"
        case favoriteFlag = "favorite_flag"
    }
}
