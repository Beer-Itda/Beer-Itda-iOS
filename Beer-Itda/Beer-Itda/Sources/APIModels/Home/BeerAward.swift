//
//  BeerAward.swift
//  Beer-Itda
//
//  Created by 초이 on 2022/01/01.
//

import Foundation

// MARK: - BeerAwardData
struct BeerAwardData: Codable {
    let beers: BeerAward
}

// MARK: - Beers
struct BeerAward: Codable {
    let kName, eName: String
    let starAvg: Int
    let thumbnailImage: String

    enum CodingKeys: String, CodingKey {
        case kName = "k_name"
        case eName = "e_name"
        case starAvg = "star_avg"
        case thumbnailImage = "thumbnail_image"
    }
}
