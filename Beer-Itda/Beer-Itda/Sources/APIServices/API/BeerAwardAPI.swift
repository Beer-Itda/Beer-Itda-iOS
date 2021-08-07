//
//  BeerAwardAPI.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/07.
//

import Moya

public class BeerAwardAPI {
    static let shared = BeerAwardAPI()
    
    var beerAwardProvider = MoyaProvider<BeerAwardService>()
    
    public init() { }
    
    func getBeerAward(startDate: String?,
                     endDate: String?,
                     limit: Int?,
                      completion: @escaping (NetworkResult<Any>) -> Void) {
        
        beerAwardProvider.request(.getBeerAward(startDate: startDate, endDate: endDate, limit: limit)) { (result) in
            
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                print(response.request?.url)
                
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
        
        guard let decodedData = try? decoder.decode(BeerListData.self, from: data) else {
            print("decode fail")
            return .pathErr
        }
        
        return .success(decodedData.result)
    }
}

