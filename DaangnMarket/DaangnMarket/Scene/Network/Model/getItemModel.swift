//
//  getItemModel.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/06/03.
//

import Foundation

struct getItemModel: Codable {
    var title: String
    var price: Int
    var image: String
    var likeCount: Int
    var chatCount: Int
    var timeBefore: String
}
