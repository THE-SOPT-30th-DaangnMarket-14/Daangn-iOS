//
//  SaleTableViewCell.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
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
        titleLabel.text = data.titleName
        localTimeLabel.text = "\(data.localName) ・ \(data.updateTime)"
        priceLabel.text = "\(data.price) 원"
    }
}
