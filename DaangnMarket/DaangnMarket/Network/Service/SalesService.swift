//
//  SalesService.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation
import Alamofire

class SalesService {
    //MARK: - Properties
    static let shared = SalesService()
    
    init() {}
    
    //MARK: - feature
    func getAllSalesPosts(completion: @escaping (NetworkResult<Any>) -> Void){
        let url = APIConstants.getAllSalesPostsURL
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        let request = AF.request(url,
                                 method: .get,
                                 headers: headers)
        
        request.responseData{ [weak self] response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value  = response.value else {return}
                guard let networkResult = self?.checkStatus(statusCode, data: value) else {return}
                completion(networkResult)
            case .failure(_):
                completion(.networkFail)
            }
        }
    }
    
    //MARK: - decoding process
    private func checkStatus(_ status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200: return isValidData(data)
        case 204: return .success(nil)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(_ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(ResponseBody<[SalesPostModel]>.self, from: data) else {return .pathErr}
        return .success(decodedData.data as Any)
        
    }
}
