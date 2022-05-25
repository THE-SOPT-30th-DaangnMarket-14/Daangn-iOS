//
//  WritingViewController.swift
//  DaangnMarket
//
//  Created by 김지현 on 2022/05/17.
//

import UIKit

class WritingViewController: UIViewController {
    
    // MARK: - 변수
    
    let placeholderColor: UIColor = .daangnGray03
    let textColor: UIColor = .daangnBlack
    let activateButtonColor: UIColor = .daangnOrange
    
    var selectedImage: [UIImage] = []{
        didSet{
            selectedImageCollectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectedImageCollectionView: UICollectionView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
  
    // MARK: - 뷰 생명주기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setToolBar()
        configureUI()
        setNavigationBar()
    }
    
    // MARK: - setup 메서드
    private func setUp() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        titleTextView.tag = 1
        priceTextView.tag = 2
        contentTextView.tag = 3
        
        priceTextView.keyboardType = .numberPad
    }
    
    private func configureUI() {

        [SelectedImageCollectionViewCell.className,
         CameraButtonCollectionViewCell.className].forEach {
            selectedImageCollectionView.register(
                UINib(nibName: $0, bundle: nil),
                forCellWithReuseIdentifier: $0)
        }
        selectedImageCollectionView.delegate = self
        selectedImageCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        selectedImageCollectionView.collectionViewLayout = flowLayout
        
        [titleTextView, priceTextView, contentTextView].forEach {
            $0?.isScrollEnabled = false
            $0?.translatesAutoresizingMaskIntoConstraints = false
            $0?.textContainerInset = UIEdgeInsets(top: 21, left: 16, bottom: 21, right: 16)
            $0?.layer.addTopBorder(width: 1)
            $0?.textColor = .daangnGray03
            $0?.delegate = self
        }
    }
    
    private func setToolBar() {
        
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: #selector(doneBtnClicked))
        doneButton.tintColor = .black

        keyboardToolBar.items = [flexibleSpace, doneButton]
        keyboardToolBar.sizeToFit()
        
        [titleTextView, priceTextView, contentTextView].forEach { $0?.inputAccessoryView = keyboardToolBar }
    }
    
    private func setNavigationBar() {

        self.navigationController?.navigationBar.isHidden = true
        let daangnNaviBar = DaangnNaviBar.createMyClassView()
        self.navigationBar.addSubview(daangnNaviBar)
        
        daangnNaviBar.dropdownImageView.isHidden = true
        daangnNaviBar.doneButton.isEnabled = false
        
        daangnNaviBar.dismissButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
        
        daangnNaviBar.doneButtonAction = {
            // postitem
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Done Button 서버통신
func postItem() {
    
}

// MARK: - Action
extension WritingViewController: CameraButtonDelegate {
    
    func cameraButtonTapped() {

        let storyboard = UIStoryboard(name: "ImagePickerViewController", bundle: nil)
        guard let imagePickerVC = storyboard.instantiateViewController(withIdentifier: "ImagePickerViewController") as? ImagePickerViewController else { return }
        
        let imagePickerNVC = UINavigationController(rootViewController: imagePickerVC)
        imagePickerNVC.modalPresentationStyle = .fullScreen
        self.present(imagePickerNVC, animated: true, completion: nil)
    }
    
    @objc func doneBtnClicked() {
        self.view.endEditing(true)
    }
}

// MARK: - TextView Delegate
extension WritingViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        isDoneButtonEnabled()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
            textView.textColor = textColor
            textView.text = nil
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let textViewText = textView.text else { return true }
        let newLength = textViewText.count + text.count - range.length
        
        if textView.tag == 1 {
            return newLength <= 15
        } else if textView.tag == 2 {
            return newLength <= 10
        } else {
            return newLength <= 1000
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.textColor = placeholderColor
            if textView.tag == 1 {
                textView.text = "글 제목"
            } else if textView.tag == 2 {
                textView.text = "₩ 가격 (선택사항)"
            } else {
                textView.text = "서림동에 올릴 게시글 내용을 작성해주세요. (가품 및 판매 금지품목은 게시가 제한될 수 있어요)"
            }
        }
    }
    
    func isDoneButtonEnabled() {
        
        guard let daangnNaviBar = navigationBar.subviews.first as? DaangnNaviBar else {return}
        if titleTextView.text.count >= 1 && priceTextView.text.count >= 1 && contentTextView.text.count >= 1 &&
            titleTextView.textColor == textColor && priceTextView.textColor == textColor && contentTextView.textColor == textColor {
            daangnNaviBar.doneButton.isEnabled = true
            daangnNaviBar.doneButton.tintColor = activateButtonColor
        } else {
            daangnNaviBar.doneButton.isEnabled = false
            daangnNaviBar.doneButton.tintColor = textColor
        }
    }
}

// MARK: - Keyboard Notification Center
extension WritingViewController {
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        
        guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return
            }
        
        let contentInset = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: keyboardFrame.size.height + 40,
                right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}

// MARK: - CollectionView Delegate & DataSource & FlowLayout
extension WritingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            guard let cameraButtonCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CameraButtonCollectionViewCell.className, for: indexPath) as? CameraButtonCollectionViewCell else { return UICollectionViewCell() }
            
            cameraButtonCell.delegate = self
            
            return cameraButtonCell
        } else {
            
            guard let selectedImageCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SelectedImageCollectionViewCell.className, for: indexPath) as? SelectedImageCollectionViewCell else { return UICollectionViewCell() }
            
            DispatchQueue.main.async {
                selectedImageCell.selectedImageView.image = self.selectedImage[indexPath.row]
                indexPath.row == 0 ? (selectedImageCell.firstImageLabel.isHidden = false) : (selectedImageCell.firstImageLabel.isHidden = true)
            }
            
            selectedImageCell.deleteButtonAction = { [unowned self] in
                
                self.selectedImageCollectionView.performBatchUpdates {

                    self.selectedImageCollectionView.deleteItems(at: [indexPath])
                    selectedImage.remove(at: indexPath.row)
                } completion: { [unowned self] _ in
                    self.selectedImageCollectionView.reloadData()
                }
            }
            
            return selectedImageCell
        }
    }
}

extension WritingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return section == 0 ? 1 : selectedImage.count
    }
}

extension WritingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 4)
        } else {
            return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 16)
        }
    }

}
