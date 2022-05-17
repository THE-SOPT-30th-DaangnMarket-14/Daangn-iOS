//
//  Int+.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import Foundation

extension Int {
    func commaToString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: self))!
        
        return result
    }
}
