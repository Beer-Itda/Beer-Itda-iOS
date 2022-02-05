//
//  AromaList.swift
//  Beer-Itda
//
//  Created by Zoe on 2022/02/05.
//

import Foundation

// MARK: - AromaList
struct AromaList: Codable {
    let aromaList: [Aroma]
}

// MARK: - AromaList
struct Aroma: Codable {
    let id: Int
    let aroma: String
    let isSelected: Bool
}
