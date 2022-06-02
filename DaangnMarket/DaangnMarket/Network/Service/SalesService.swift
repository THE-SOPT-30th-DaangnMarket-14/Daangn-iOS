//
//  SalesService.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation
import Alamofire
import UIKit

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
    
    func addSalesPost(title: String,
                      price: Int,
                      contents: String,
                      images: [UIImage],
                      compleion: @escaping (NetworkResult<Any>) -> Void
    ){
        let url = APIConstants.addSalesPostURL
        let headers: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let body: Parameters = [
            "title" : title,
            "price" : price,
            "contents" : contents
        ]
        
        let request = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in body {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            images.forEach{ image in
                if let imageData = image.pngData() {
                    print("\(imageData).png")
                    multipartFormData.append(imageData, withName: "image", fileName: "\(imageData).png", mimeType: "image/png")
                }
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
        
        request.responseData{ [weak self] response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                guard let networkResult = self?.checkStatus(statusCode, data: value) else {return}
                compleion(networkResult)
            case .failure(_):
                compleion(.networkFail)
            }
        }
    }
    
    //MARK: - decoding process
    private func checkStatus(_ status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200: return isValidData(data)
        case 201, 204: return .success(nil)
        case 400: return .requestErr(nil)
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
