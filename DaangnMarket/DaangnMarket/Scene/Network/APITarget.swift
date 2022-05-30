//
//  APITarget.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/31.
//

import Foundation
import Alamofire

enum APITarget {
    case getItem
    case postItem(title: String, price: Int, contents: String, image: URL)
}

extension APITarget: TargetType {
    
    var baseURL: String {
        return APIConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getItem:
            return APIConstants.itemPath
        case .postItem:
            return APIConstants.itemPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getItem:
            return .get
        case .postItem:
            return .post
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getItem:
            return .body(nil)
        case .postItem(let title, let price, let contents, let image):
            let body: [String : Any] = [
                "title" : title,
                "price" : price,
                "contents" : contents,
                "image" : image
            ]
            return .requestParameters(body)
        }
    }
}
