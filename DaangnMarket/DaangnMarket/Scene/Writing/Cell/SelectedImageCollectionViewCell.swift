//
//  SelectedImageCollectionViewCell.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/19.
//

import UIKit

class SelectedImageCollectionViewCell: UICollectionViewCell {
    
    var deleteButtonAction : (() -> ())?
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var firstImageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
        configureUI()
    }
    
    func setUp() {
     
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
    }
    
    func configureUI() {
        
        baseView.makeRounded(cornerRadius: 4)
        firstImageLabel.text = "대표 사진"
        selectedImageView.contentMode = .scaleAspectFit
    }
    
    @objc func deleteButtonClicked() {
        deleteButtonAction?()
    }
}
