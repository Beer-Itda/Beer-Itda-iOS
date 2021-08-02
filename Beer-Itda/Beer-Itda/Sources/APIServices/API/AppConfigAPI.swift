//
//  AppConfigAPi.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/02.
//

import Moya

public class AppConfigAPI {
    static let shared = AppConfigAPI()
    
    var appConfigProvider = MoyaProvider<AppConfigService>()
    
    public init() { }
    
    func getAppConfig(completion: @escaping (NetworkResult<Any>) -> Void) {
        appConfigProvider.request(.getAppConfig) { (result) in
            
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data)
        case 400..<500:
            return .pathErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(AppConfigData.self, from: data) else {
            print("decode fail")
            return .pathErr
        }
        
        return .success(decodedData.result)
    }
}
