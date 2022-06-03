//
//  APIService.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/06/03.
//

import UIKit

import Alamofire

struct APIService {
    static let shared = APIService()
    private init() {}
}

extension APIService {
    
    func requestPostItem(title: String, price: Int, contents: String, images: [UIImage], completion: @escaping (NetworkResult<postItemModel>) -> (Void)) {
        
        let target = APITarget.postItem(title: title, price: price, contents: contents)
        AF.upload(multipartFormData: target.multipartFormData(title, price, contents, images), with: target)
            .responseData { dataResponse in
                responseWithNoData(dataResponse, completion: completion)
            }
    }
    
    func requestGetItem(completion: @escaping (NetworkResult<[getItemModel]>) -> (Void)) {
        print(#function)
        let target = APITarget.getItem
        AF.request(target)
            .responseData { dataResponse in
                responseData(dataResponse, completion: completion)
            }
    }
}

extension APIService {
    
    func responseData<T: Codable>(_ dataResponse: AFDataResponse<Data>, completion: @escaping (NetworkResult<T>) -> Void) {
        
        switch dataResponse.result {
        case .success:
            
            switch dataResponse.response?.statusCode {
            case HTTPStatusCode.SERVER_ERROR.rawValue:
                completion(.serverErr)
            default:
                guard let data = dataResponse.value else { return }
                guard let decodedData = try? JSONDecoder().decode(CommonResponse<T>.self, from: data) else {
                    return completion(.pathErr)
                }
                
                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message))
                }
                
                completion(.success(data))
            }

        case .failure(let err):
            print(err)
            completion(.networkFail)
        }
    }
    
    func responseWithNoData<T: Codable>(_ dataResponse: AFDataResponse<Data>, completion: @escaping (NetworkResult<T>) -> Void) {
        
        switch dataResponse.result {
        case .success:
            
            switch dataResponse.response?.statusCode {
            case HTTPStatusCode.SERVER_ERROR.rawValue:
                completion(.serverErr)
            default:
                guard let data = dataResponse.value else { return }
                guard let decodedData = try? JSONDecoder().decode(CommonResponse<T>.self, from: data) else {
                    return completion(.pathErr)
                }
                print(decodedData.message)
                completion(.success(nil))
            }

        case .failure(let err):
            print(err)
            completion(.networkFail)
        }
    }
}
