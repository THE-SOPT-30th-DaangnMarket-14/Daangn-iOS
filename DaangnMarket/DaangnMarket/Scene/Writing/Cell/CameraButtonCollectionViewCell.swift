//
//  CameraButtonCollectionViewCell.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/19.
//

import UIKit

class CameraButtonCollectionViewCell: UICollectionViewCell {
    
    var imageNum = 4 {
        didSet {
            if imageNum != 0 {
                let mutableAttributedString = NSMutableAttributedString()
                    .setColor(string: "\(imageNum)", to: .daangnOrange)
                    .setColor(string: " /10", to: .daangnGray04)
                cameraButton.titleLabel?.attributedText = mutableAttributedString
            }
        }
    }
    
    @IBOutlet weak var cameraButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {

        cameraButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTF", size: 11)
        cameraButton.makeRounded(cornerRadius: 4)
        cameraButton.layer.borderWidth = 1
        cameraButton.layer.borderColor = UIColor.daangnGray01.cgColor
    }

}
