//
//  APIManager.swift
//  Beer-Itda
//
//  Created by Zoe on 2022/02/05.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    // MARK: - Public methods
    
    func call(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<(), AlertMessage>) -> Void) {
        AF.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { (data) in
                                        switch data.result {
                                        case .success(_):
                                            handler(.success(()))
                                        case .failure(_):
                                            print("Error in call")
                                        }
        }
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<T, AlertMessage>) -> Void) where T: Codable {
        AF.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { (data) in
                                        do {
                                            guard let jsonData = data.data else {
                                                throw AlertMessage(title: "Error", body: "No data")
                                            }
                                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                                            handler(.success(result))
                                        } catch {
                                            if let error = error as? AlertMessage {
                                                return handler(.failure(error))
                                            }
                                            
                                            print("Error in call ")
                                        }
        }
    }
}
