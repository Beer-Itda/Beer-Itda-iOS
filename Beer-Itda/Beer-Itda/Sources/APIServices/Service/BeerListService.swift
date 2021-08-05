//
//  BeerListService.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/04.
//

import Foundation
import Moya

let devToken = "4c3784d4f28f5b435c51f375"

enum Sort: String {
    case sortByRateAvgAsc = "rate_avg_asc"
    case sortByRateAvgDesc = "rate_avg_desc"
    case sortByReviewCountAsc = "review_count_asc"
    case sortByReviewCountDesc = "review_count_desc"
}

enum BeerListService {
    case getBeerList(minAbv: Int?, maxAbv: Int?, style: [String]?, scent: [String]?, cursor: Int?, maxCount: Int?, sort: Sort?)
}

extension BeerListService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getBeerList(_, _, _, _, _, _, _):
            return Const.URL.beerList
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBeerList(_, _, _, _, _, _, _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBeerList(let minAbv, let maxAbv, let style, let scent, let cursor, let maxCount, let sort):
            
            var params: [String:Any] = [:]
            
            if let minAbv = minAbv {
                params["min_abv"] = minAbv
            }
            
            if let maxAbv = maxAbv {
                params["max_abv"] = maxAbv
            }
            
            if let beerStyle = style {
                params["beer_style"] = beerStyle
            }
            
            if let aroma = scent {
                params["aroma"] = aroma
            }
            
            if let cursor = cursor {
                params["cursor"] = cursor
            }
            
            if let maxCount = maxCount {
                params["max_count"] = maxCount
            }
            
            if let sort = sort {
                params["sort_by"] = sort
            }
        
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String]? {
            return ["Authorization": devToken]
        }
        return headers
    }
}
