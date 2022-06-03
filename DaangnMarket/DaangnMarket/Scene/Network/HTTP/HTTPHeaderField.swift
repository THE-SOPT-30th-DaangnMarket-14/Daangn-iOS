//
//  HTTPHeaderField.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/31.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}
