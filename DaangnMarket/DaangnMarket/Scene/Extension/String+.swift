//
//  String+.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/06/02.
//

import Foundation

extension String {
    func removeCommaStringToInt() -> Int {
        let removedComma = self.components(separatedBy: [",", "₩", " "]).joined()
        return Int(removedComma) ?? 0
    }
}
