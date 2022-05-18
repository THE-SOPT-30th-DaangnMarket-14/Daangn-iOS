//
//  CALayer+.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/17.
//

import UIKit
import QuartzCore

extension CALayer {
    
    func addTopBorder(width: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: width)
        border.backgroundColor = UIColor.daangnGray00.cgColor
        self.addSublayer(border)
    }
}
