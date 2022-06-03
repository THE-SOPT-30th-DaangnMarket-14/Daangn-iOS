//
//  SalePostDataModel.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/06/01.
//

import Foundation

struct SalePostDataModel: Codable {
    var title: String
    var price: Int
    var image: String
    var likeCount: Int
    var chatCount: Int
    var timeBefore: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
        case image = "image"
        case likeCount = "likeCount"
        case chatCount = "chatCount"
        case timeBefore = "timeBefore"
    }
}
