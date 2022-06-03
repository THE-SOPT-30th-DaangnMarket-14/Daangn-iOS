//
//  HomeViewController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    var itemList: [getItemModel] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItem()
    }

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
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.className, for: indexPath) as? SaleTableViewCell else { return UITableViewCell() }
        
        cell.setData(data: itemList[indexPath.row])
        return cell
    }
}

extension HomeViewController {
    
    func getItem() {
        APIService.shared.requestGetItem { result in
            print(result)
            switch result {
            case .success(let response):
                guard let items = response else { return }
                self.itemList = items
                DispatchQueue.main.async {
                    self.saleTableView.reloadData()
                }
            case .requestErr(_):
                print("리퀘스트 에러")
            case .networkFail:
                print("네트워크 통신 실패 alert")
            case .serverErr:
                print("서버에러")
            case .pathErr:
                print("에러")
            }
        }
    }
}
