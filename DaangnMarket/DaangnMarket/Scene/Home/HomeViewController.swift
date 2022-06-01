//
//  HomeViewController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var localSelectBtn: UIButton!
    @IBOutlet weak var orangeDotImageView: UIImageView!
    @IBOutlet weak var saleTableView: UITableView! {
        didSet {
            saleTableView.dataSource = self
            saleTableView.rowHeight = 127
            saleTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
    @IBOutlet weak var addBtn: UIButton! {
        didSet {
            addBtn.makeRounded(cornerRadius: addBtn.frame.width / 2)
            addBtn.addShadow(offset: CGSize(width: 0, height: 3))
        }
    }
    
    var salePostData: [SalePostDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureUI()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: SaleTableViewCell.className, bundle: nil)
        self.saleTableView.register(nib, forCellReuseIdentifier: SaleTableViewCell.className)
    }
    
    private func configureUI() {
        localSelectBtn.setTitle("서림동", for: .normal)
        orangeDotImageView.isHidden = false
    }
    
    @IBAction func tapLocalSelectBtn(_ sender: Any) {
        
    }
    
    @IBAction func tapAddBtn(_ sender: Any) {
        guard let writingViewController = UIStoryboard.init(name: "WritingViewController", bundle: nil).instantiateViewController(withIdentifier: "WritingViewController") as? WritingViewController else { return }
        writingViewController.modalPresentationStyle = .fullScreen
        
        self.present(writingViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salePostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.className, for: indexPath) as? SaleTableViewCell else { return UITableViewCell() }
        
        cell.setData(data: salePostData[indexPath.row])
        return cell
    }
}
