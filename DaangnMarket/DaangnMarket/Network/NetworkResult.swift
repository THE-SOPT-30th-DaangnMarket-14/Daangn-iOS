//
//  NetworkResult.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/06/01.
//

import Foundation

enum NetworkResult<T> {
    case success(T?)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
