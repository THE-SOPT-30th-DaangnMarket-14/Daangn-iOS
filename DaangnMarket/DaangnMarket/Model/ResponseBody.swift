//
//  ResponseBody.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation

struct ResponseBody<T: Codable> : Codable{
    let status: Int
    let success: Bool
    let message : String
    let data: T?
}
