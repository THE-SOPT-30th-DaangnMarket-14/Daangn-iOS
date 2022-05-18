//
//  UIView+.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

extension UIView {
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /// UIView 의 모서리가 둥근 정도를 설정하는 메서드
    func makeRounded(cornerRadius : CGFloat?) {
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    /// UIView의 그림자를 설정하는 메서드
    func addShadow(offset: CGSize, color: UIColor = .gray, opacity: Float = 0.25, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
