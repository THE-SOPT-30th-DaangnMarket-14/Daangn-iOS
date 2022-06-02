//
//  SaleTableViewCell.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit
import Alamofire

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
    
    func setData(data: SalesPostModel) {
        configurePostImageFromURL(data.image)
        postTitleLabel.text = data.title
        localTimeLabel.text = data.timeBefore
        priceLabel.text = "\(data.price.commaToString()) 원"
    }
    
    private func configurePostImageFromURL(_ imageURL: String) {
        let request = AF.request(imageURL, method: .get)
        
        request.responseData{ [weak self] response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                self?.postImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
