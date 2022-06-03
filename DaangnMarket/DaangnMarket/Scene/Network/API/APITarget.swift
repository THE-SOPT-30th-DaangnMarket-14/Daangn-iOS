//
//  APITarget.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/31.
//

import Foundation
import Alamofire
import UIKit

enum APITarget {
    case getItem
    case postItem(title: String, price: Int, contents: String)
}

extension APITarget: TargetType {
    
    var requestType: RequestType {
        switch self {
        case .getItem:
            return .dataRequest
        case .postItem:
            return .requestUpload
        }
    }
    
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
    
    var parameters: Encodable? {
        switch self {
        case .getItem:
            return nil
        case .postItem:
            return nil
        }
    }
}
