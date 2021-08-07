//
//  BeerAwardService.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/07.
//

import Foundation
import Moya

enum BeerAwardService {
    case getBeerAward(startDate: String?, endDate: String?, limit: Int?)
}

extension BeerAwardService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        return Const.URL.beerAward
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBeerAward(let startDate, let endDate, let limit):
            
            var params: [String: Any] = [:]
            
//            if let startDate = startDate {
//                params["start_date"] = startDate
//            }
//            
//            if let endDate = endDate {
//                params["end_date"] = endDate
//            }
//            
//            if let limit = limit {
//                params["limit"] = limit
//            }
            
            return .requestParameters(parameters: params, encoding: ArrayEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var headers: [String: String]? {
            return ["Authorization": devToken]
        }
        return headers
    }
    
    
}
