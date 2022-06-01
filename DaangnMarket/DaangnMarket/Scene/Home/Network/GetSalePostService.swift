//
//  GetSalePostService.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/06/01.
//

import Foundation
import Alamofire

struct GetSalePostService {
    static let shared = GetSalePostService()
    
    func requestGetSalePost(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.getSalePost
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: APIConstants.jsonHeader)
        
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeGetSalePost(by: statusCode, value)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeGetSalePost(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isVaildGetSalePostData(data: data)
        case 204: return .success([])
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isVaildGetSalePostData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[SalePostDataModel]>.self, from: data) else { return .pathErr }
        debugPrint(decodedData)
        return .success(decodedData.data ?? "None-Data")
    }
}
