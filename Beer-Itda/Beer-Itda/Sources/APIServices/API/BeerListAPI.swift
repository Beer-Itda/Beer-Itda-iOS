//
//  BeerListAPI.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/05.
//

import Moya

public class BeerListAPI {
    static let shared = BeerListAPI()
    
    var beerListProvider = MoyaProvider<BeerListService>()
    
    public init() { }
    
    func getBeerList(minAbv: Int?,
                      maxAbv: Int?,
                      style: [String]?,
                      scent: [String]?,
                      cursor: Int?,
                      maxCount: Int?,
                      sort: Sort?,
                      completion: @escaping (NetworkResult<Any>) -> Void) {
        beerListProvider.request(.getBeerList(minAbv: minAbv,
                                              maxAbv: maxAbv,
                                              style: style,
                                              scent: scent,
                                              cursor: cursor,
                                              maxCount: maxCount,
                                              sort: sort)) { (result) in
            
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
