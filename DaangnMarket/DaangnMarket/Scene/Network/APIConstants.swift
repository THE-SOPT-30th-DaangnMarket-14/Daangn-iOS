//
//  APIConstants.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/06/01.
//

import Foundation
import Alamofire

struct APIConstants {
    // MARK: Base URL
    static let baseURL = "http://52.78.114.176:8000"
    
    // MARK: Feature URL
    static let getSalePost = baseURL + "/item"
    static let postSalePost = baseURL + "/item"
    
    static func getMyPlayListDetailURL(id: String) -> String {
        return baseURL + "/playlist/\(id)"
    }
    
    static func likeMyPlayListURL(id: String) -> String {
        return baseURL + "/playlist/\(id)/like"
    }
    
    // MARK: Header
    static let jsonHeader: HTTPHeaders = ["Content-Type": "application/json"]
    static let multipartHeader: HTTPHeaders = ["Content-Type": "multipart/form-data"]
}
