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
    
    func setData(data: getItemModel) {
        
        postImageView.setImageURL(url: data.image)
        postTitleLabel.text = data.title
        localTimeLabel.text = "떙땡동 ・ \(data.timeBefore)"
        priceLabel.text = "\(data.price.commaToString()) 원"
    }
}
