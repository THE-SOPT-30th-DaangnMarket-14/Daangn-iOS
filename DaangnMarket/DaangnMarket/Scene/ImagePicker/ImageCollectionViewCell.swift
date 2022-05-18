//
//  ImageCollectionViewCell.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/05/17.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlet
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    static let identifier = "ImageCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    //MARK: - View
    var countButton: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        view.setBackgroundImage(UIImage(named: "ic_count_circle_unselect_24"), for: .normal)
        view.setBackgroundImage(UIImage(named: "ic_count_circle_non_24"), for: .selected)
        view.setTitleColor(UIColor.daangnWhite, for: .selected)
        view.titleLabel?.font = UIFont(name: "NanumBarunGothicBold", size: 14)
        
        return view
    }()
    
    //MARK: - Configure
    private func configureView(){
        imageView.addSubview(countButton)
        
        countButton.translatesAutoresizingMaskIntoConstraints = false
        countButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6).isActive = true
        countButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -6).isActive = true
        countButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        countButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func configureCell(_ image: UIImage, indexPath: IndexPath){
        self.imageView.image = image
        
        countButton.isHidden = indexPath.row == 0 ? true : false
        countButton.setTitle(String(indexPath.row), for: .selected)
        countButton.isSelected = true
    }
}
