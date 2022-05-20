//
//  ImageCollectionViewCell.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/05/17.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
    func didSelectCountButton(_ cell: ImageCollectionViewCell)
}

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlet
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    static let identifier = "ImageCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    var isSelectedImage: Bool = false {
        didSet{
            imageView.layer.borderColor = isSelectedImage ? UIColor.daangnOrange.cgColor : UIColor.clear.cgColor
        }
    }
    var isSelectedStatus: Bool = false
    var index: Int = 0
    
    weak var delegate: ImageCollectionViewCellDelegate?
    
    //MARK: - View
    var countButton: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        view.setBackgroundImage(UIImage(named: "ic_count_circle_unselect_24"), for: .normal)
        view.setBackgroundImage(UIImage(named: "ic_count_circle_non_24"), for: .selected)
        view.setTitleColor(UIColor.daangnWhite, for: .selected)
        view.titleLabel?.font = UIFont(name: "NanumBarunGothicBold", size: 14)
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    //MARK: - Configure
    private func configureView(){
        countButton.addTarget(self, action: #selector(didTouchDownCountButton), for: .touchUpInside)
        contentView.addSubview(countButton)
        
        countButton.translatesAutoresizingMaskIntoConstraints = false
        countButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6).isActive = true
        countButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -6).isActive = true
        countButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        countButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configureCell(_ data: ImageData){
        self.imageView.image = data.image
        countButton.isHidden = index == 0
        
        if data.selectedNumber != nil {
            guard let selectedNumber = data.selectedNumber else {return}
            countButton.setTitle(String(selectedNumber), for: .selected)
        }
        countButton.isSelected = data.selectedNumber != nil
        isSelectedImage = data.selectedNumber != nil
    }
    
    //MARK: - @objc
    @objc private func didTouchDownCountButton(){
        delegate?.didSelectCountButton(self)
    }
}
