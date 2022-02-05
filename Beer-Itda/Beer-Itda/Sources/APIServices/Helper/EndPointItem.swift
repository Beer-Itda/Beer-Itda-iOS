//
//  EndPointItem.swift
//  Beer-Itda
//
//  Created by Zoe on 2022/02/05.
//

import Foundation
import Alamofire

enum EndpointItem {
    
    // MARK: beer
    // MARK: user
    // MARK: select
    // MARK: information
    // 모든 스타일 정보 불러오기
    case styleInfo
    // 모든 향 정보 불러오기
    case aromaInfo
    // MARK: review
    // MARK: heart
    // MARK: level
    
}

// MARK: - Extensions
// MARK: - EndPointType
extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        return "https://beeritda.com/api/v1/"
    }
    
    var path: String {
        switch self {
            
        case .styleInfo:
            return "information/style"
        case .aromaInfo:
            return "information/aroma"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "" )"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
