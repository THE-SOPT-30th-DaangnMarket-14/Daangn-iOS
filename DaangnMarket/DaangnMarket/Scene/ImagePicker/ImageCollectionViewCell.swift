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
    
    //MARK: - View
    var countView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.backgroundColor = .clear
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.daangnBlack.cgColor
        
        view.layer.shadowColor = UIColor.daangnBlack.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    //MARK: - Configure
    private func configureView(){
        imageView.addSubview(countView)
        
        countView.translatesAutoresizingMaskIntoConstraints = false
        countView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8).isActive = true
        countView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8).isActive = true
        countView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
