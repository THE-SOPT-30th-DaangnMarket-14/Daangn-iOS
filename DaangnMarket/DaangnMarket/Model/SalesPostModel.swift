//
//  SalesPostModel.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation

struct SalesPostModel: Codable {
    let title: String
    let price: Int
    let image: String
    let likeCount: Int
    let chatCount: Int
    let timeBefore: String
}
