//
//  AppConfigService.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/02.
//

import Moya

enum AppConfigService {
    case getAppConfig
}

extension AppConfigService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAppConfig:
            return Const.URL.appConfig
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAppConfig:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAppConfig:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers: [String: String]? {
            return [:]
        }
        return headers
    }
}
