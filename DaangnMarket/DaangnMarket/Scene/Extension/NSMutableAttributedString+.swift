//
//  NSMutableAttributedString+.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/19.
//

import UIKit

extension NSMutableAttributedString {

    func setColor(string: String, to color: UIColor) -> NSMutableAttributedString {
        let attribute: [NSAttributedString.Key: Any] = [.foregroundColor : color]
        self.append(NSAttributedString(string: string, attributes: attribute))
        return self
    }
}
