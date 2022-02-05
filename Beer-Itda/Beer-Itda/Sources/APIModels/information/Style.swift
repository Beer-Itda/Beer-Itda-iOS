//
//  Style.swift
//  Beer-Itda
//
//  Created by Zoe on 2022/02/05.
//

import Foundation

// MARK: - StyleList
struct StyleList: Codable {
    let styleList: [Style]
}

// MARK: - StyleList
struct Style: Codable {
    let id: Int
    let bigName: String
    let styleMids: [StyleMid]

    enum CodingKeys: String, CodingKey {
        case id
        case bigName = "big_name"
        case styleMids = "Style_Mids"
    }
}

// MARK: - StyleMid
struct StyleMid: Codable {
    let id: Int
    let midName, midDescription, midImage: String
    let bigStyleID: Int
    let styleSmalls: [StyleSmall]

    enum CodingKeys: String, CodingKey {
        case id
        case midName = "mid_name"
        case midDescription = "mid_description"
        case midImage = "mid_image"
        case bigStyleID = "big_style_id"
        case styleSmalls = "Style_Smalls"
    }
}

// MARK: - StyleSmall
struct StyleSmall: Codable {
    let id: Int
    let smallName: String
    let midStyleID: Int
    let isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case smallName = "small_name"
        case midStyleID = "mid_style_id"
        case isSelected
    }
}
