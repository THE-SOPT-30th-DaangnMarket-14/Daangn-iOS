//
//  CameraButtonCollectionViewCell.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/19.
//

import UIKit

protocol CameraButtonDelegate {
    func cameraButtonTapped()
}

class CameraButtonCollectionViewCell: UICollectionViewCell {
    
    var delegate: CameraButtonDelegate?
    
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
        
        setUp()
        configureUI()
    }
    
    func setUp() {
        
        cameraButton.addTarget(self, action: #selector(cameraButtonClicked), for: .touchUpInside)
    }
    
    func configureUI() {

        cameraButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTF", size: 11)
        cameraButton.makeRounded(cornerRadius: 4)
        cameraButton.layer.borderWidth = 1
        cameraButton.layer.borderColor = UIColor.daangnGray01.cgColor
    }
    
    // delegate 메서드명과 selector 메서드명
    @objc func cameraButtonClicked() {
        delegate?.cameraButtonTapped()
    }

}
