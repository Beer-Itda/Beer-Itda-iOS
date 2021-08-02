//
//  AppConfig.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/02.
//

import Foundation

struct AppConfigData: Codable {
    let result: AppConfig
}

// MARK: - AppConfig
struct AppConfig: Codable {
    let aromaList, countryList, styleList: [String]
    let minAbv, maxAbv: Int

    enum CodingKeys: String, CodingKey {
        case aromaList = "aroma_list"
        case countryList = "country_list"
        case styleList = "style_list"
        case minAbv = "min_abv"
        case maxAbv = "max_abv"
    }
}
