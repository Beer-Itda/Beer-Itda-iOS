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
        static let baseURL = "http://18.183.212.12:8081/api"
        
        // app config (GET)
        static let appConfig = "/app-config"
        
        // beer-list (GET)
        static let beerList = "/beers"
        
        // get popular beers (GET)
        static let beerAward = "/popular-beers"
    }
    
}
