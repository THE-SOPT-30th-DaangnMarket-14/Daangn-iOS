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
    
    var salesPosts: [SalesPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllSalesPosts()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: SaleTableViewCell.className, bundle: nil)
        self.saleTableView.register(nib, forCellReuseIdentifier: SaleTableViewCell.className)
    }
    
    private func configureUI() {
        localSelectBtn.setTitle("서림동", for: .normal)
        orangeDotImageView.isHidden = false
    }
    
    private func fetchAllSalesPosts(){
        SalesService.shared.getAllSalesPosts{ [weak self] networkResult in
            switch networkResult {
            case .success(let data):
                guard let data = data as? [SalesPostModel] else {return}
                self?.salesPosts = data
                self?.saleTableView.reloadData()
            case .requestErr(let error):
                print(error ?? "")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
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
        return salesPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.className, for: indexPath) as? SaleTableViewCell else { return UITableViewCell() }
        
        cell.setData(data: salesPosts[indexPath.row])
        return cell
    }
}
