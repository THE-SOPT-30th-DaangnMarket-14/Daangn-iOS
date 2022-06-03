//
//  UIImageView+.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/06/03.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageURL(url: String) {
        
        if let url = URL(string: url) {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.image = image
                }
            }
        }
    }
}
