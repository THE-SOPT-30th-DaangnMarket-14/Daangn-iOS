//
//  SaleTableViewCell.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.makeRounded(cornerRadius: 7)
        }
    }
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var localTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: SaleModel) {
        postImageView.image = UIImage(named: data.imageName)
        postTitleLabel.text = data.titleName
        localTimeLabel.text = "\(data.localName) ・ \(data.updateTime) 분/시간 전"
        priceLabel.text = "\(data.price.commaToString()) 원"
    }
}
