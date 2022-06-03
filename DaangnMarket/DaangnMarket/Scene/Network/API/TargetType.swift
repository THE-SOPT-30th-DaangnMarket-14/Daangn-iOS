//
//  TargetType.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/06/03.
//

import Foundation
import Alamofire
import UIKit

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Encodable? { get }
    var requestType: RequestType { get }
}

extension TargetType {

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        switch requestType {
        case .dataRequest:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        case .requestUpload:
            urlRequest.setValue(ContentType.multipart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }

        if let parameters = parameters {
            let params = parameters.toDictionary()
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }

        return urlRequest
    }
    
    // 모델 stuct화 추후 리팩토링
    func multipartFormData(_ title: String, _ price: Int, _ contents: String, _ images: [UIImage]) -> MultipartFormData {
        let multipartFormData = MultipartFormData()
        multipartFormData.append(Data(title.utf8), withName: "title")
        multipartFormData.append(Data(String(price).utf8), withName: "price")
        multipartFormData.append(Data(contents.utf8), withName: "contents")
        for image in images {
            multipartFormData.append(image.jpegData(compressionQuality: 1.0) ?? Data(), withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
        }
        return multipartFormData
    }
}

enum RequestType {
    case requestUpload
    case dataRequest
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
