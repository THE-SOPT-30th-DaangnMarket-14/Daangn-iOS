//
//  CommonResponse.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/06/03.
//

import Foundation

struct CommonResponse<T: Codable>: Codable {
    
    let status: Int
    let success: Bool
    let message: String
    let data: T?
}
