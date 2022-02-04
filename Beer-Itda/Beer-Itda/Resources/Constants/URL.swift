//
//  URL.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/02.
//

import Foundation

extension Const {
    
    struct URL {
        
        // base url
        static let baseURL = "https://beeritda.com/api/v1"
        
        // MARK: - Home
        
        // [GET] ~/beer/monthly : 이 달의 맥주 불러오기
        static let beerAward = Const.URL.baseURL + "/beer/monthly"
        // [GET] ~/beer/style : 좋아하는 스타일 맥주 불러오기
        static let beerStyle = Const.URL.baseURL + "/beer/style"
        // [GET] ~/beer/aroma : 좋아하는 향 맥주 불러오기
        static let beerAroma = Const.URL.baseURL + "/beer/aroma"
        // [GET] ~/beer/random : 맥주 랜덤 불러오기
        static let beerRandom = Const.URL.baseURL + "/beer/random"
        
        // MARK: - Filter
    }
    
}
