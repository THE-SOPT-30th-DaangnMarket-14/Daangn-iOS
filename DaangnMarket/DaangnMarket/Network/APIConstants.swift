//
//  APIConstants.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation

struct APIConstants {
    //MARK: - Base URL
    static let baseURL = "http://52.78.114.176:8000"
    
    //MARK: - Feature URL
    static let getAllSalesPostsURL = baseURL + "/item"
    static let addSalesPostURL = baseURL + "/item"
}
