//
//  HomeViewController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var saleTableView: UITableView! {
        didSet {
            saleTableView.dataSource = self
        }
    }
    
    var saleDummyData = [
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 2, price: 333333),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 1, price: 1004400),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000),
        SaleModel(imageName: "iosImgHomeList", titleName: "폰케팔아염", localName: "서림동", updateTime: 3, price: 10000)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
