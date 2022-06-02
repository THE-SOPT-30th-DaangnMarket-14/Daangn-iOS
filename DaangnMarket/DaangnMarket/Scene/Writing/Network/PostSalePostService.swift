//
//  PostSalePostService.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/06/01.
//

import Foundation
import Alamofire
import UIKit

struct PostSalePostService {
    static let shared = PostSalePostService()
    
    func requestPostSalePost(data: SalePostBodyModel, imageList: [UIImage], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = URL(string: APIConstants.postSalePost)!
        
        let request = AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(data.title.utf8), withName: "title")
            multipartFormData.append(Data(String(data.price).utf8), withName: "price")
            multipartFormData.append(Data(data.contents.utf8), withName: "contents")
            
            imageList.forEach { image in
                multipartFormData.append(image.jpegData(compressionQuality: 1.0) ?? Data(), withName: "image", fileName: "iOSimage" + DateFormatter().string(from: Date()) + ".jpeg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: APIConstants.multipartHeader)
        
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgePostSalePost(by: statusCode, value)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    private func judgePostSalePost(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 201: return isVaildPostSalePostData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isVaildPostSalePostData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericNoDataResponse.self, from: data) else { return .pathErr }
        debugPrint(decodedData)
        return .success("Success")
    }
}

