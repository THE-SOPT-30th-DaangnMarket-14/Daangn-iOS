//
//  WritingViewController.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/17.
//

import UIKit

class WritingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setToolBar()
        configureUI()
    }
    
    @objc func doneBtnClicked() {
        self.view.endEditing(true)
    }
    
    func setUp() {
        
        titleTextView.tag = 1
        priceTextView.tag = 2
        contentTextView.tag = 3
        
        priceTextView.keyboardType = .numberPad
    }
    
    func configureUI() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleTextView, priceTextView, contentTextView].forEach {
            $0?.isScrollEnabled = false
            $0?.translatesAutoresizingMaskIntoConstraints = false
            $0?.textContainerInset = UIEdgeInsets(top: 21, left: 16, bottom: 21, right: 16)
            $0?.layer.addTopBorder(width: 1)
            $0?.textColor = .daangnGray03
            $0?.delegate = self
        }
    }
    
    func setToolBar() {
        
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: #selector(doneBtnClicked))
        doneButton.tintColor = .black
        
        keyboardToolBar.items = [flexibleSpace, doneButton]
        keyboardToolBar.sizeToFit()
        
        [titleTextView, priceTextView, contentTextView].forEach { $0?.inputAccessoryView = keyboardToolBar }
    }
}

extension WritingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .daangnGray03 {
            textView.textColor = .black
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .daangnGray03
            if textView.tag == 1 {
                textView.text = "글 제목"
            } else if textView.tag == 2 {
                textView.text = "₩ 가격 (선택사항)"
            } else {
                textView.text = "서림동에 올릴 게시글 내용을 작성해주세요. (가품 및 판매 금지품목은 게시가 제한될 수 있어요)"
            }
        }
    }
}
