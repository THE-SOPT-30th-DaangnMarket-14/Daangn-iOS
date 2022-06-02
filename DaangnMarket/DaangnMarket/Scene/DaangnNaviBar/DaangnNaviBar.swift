//
//  DaangnNaviBar.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/21.
//

import UIKit

final class DaangnNaviBar: UIView {
    
    var dismissButtonAction: (() -> ())?
    var doneButtonAction: (() -> ())?
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var naviBarTitleLabel: UILabel!
    @IBOutlet weak var dropdownImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    class func createMyClassView() -> DaangnNaviBar {
        let myClassNib = UINib(nibName: "DaangnNavigationBar", bundle: nil)
        let view = myClassNib.instantiate(withOwner: self, options: nil).first as! DaangnNaviBar
        
        return view
    }
    
    func setUp() {
        
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        dismissButtonAction?()
    }
    
    @objc func doneButtonClicked() {
        doneButtonAction?()
    }
}
