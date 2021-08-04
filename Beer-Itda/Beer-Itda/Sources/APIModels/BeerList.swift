//
//  BeerListData.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/04.
//

import Foundation

struct BeerListData: Codable {
    let result: BeerList
}

struct BeerList: Codable {
    let beers: [Beer]
    let nextCursor: Int?

    enum CodingKeys: String, CodingKey {
        case beers
        case nextCursor = "next_cursor"
    }
}
