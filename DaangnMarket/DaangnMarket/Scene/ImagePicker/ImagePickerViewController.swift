//
//  ImagePickerViewController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/14.
//

import Foundation
import UIKit
import Photos

class ImagePickerViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var navigationBarView: UIView!
    
    var selectedImages: [UIImage] = []{
        didSet{
            guard let daangnNaviBar = navigationBarView.subviews.first as? DaangnNaviBar else {return}
            
            if selectedImages.count > 0 {
                let mutableAttributedString = NSMutableAttributedString()
                    .setColor(string: "\(selectedImages.count)", to: .daangnOrange)
                    .setColor(string: " 확인", to: .daangnBlack)
                daangnNaviBar.doneButton.setAttributedTitle(mutableAttributedString, for: .normal)
                
                daangnNaviBar.doneButton.isEnabled = true
                return
            }
            daangnNaviBar.doneButton.isEnabled = false
        }
    }
    var images: [ImageData] = []
    
    let imageViewPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureNavigationBarView()
        addNotificationObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestAccessPhotoLibrary()
    }
    
    private func configureCollectionView(){
        if let cameraImage = UIImage(named: "ios_list_camera") {
            images.insert(ImageData(image: cameraImage, selectedNumber: nil),at: 0)
        }
        
        imageCollectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
        self.imageViewPicker.delegate = self
    }
    
    private func configureNavigationBarView(){
        self.navigationController?.isNavigationBarHidden = true
        
        let daangnNaviBar = DaangnNaviBar.createMyClassView()
        daangnNaviBar.naviBarTitleLabel.text = "최근 항목"
        daangnNaviBar.doneButton.setAttributedTitle(NSAttributedString(string: "확인"), for: .disabled)
        daangnNaviBar.doneButton.isEnabled = false
        
        daangnNaviBar.dismissButtonAction = {
            self.dismiss(animated: true)
        }
        daangnNaviBar.doneButtonAction = {
            guard let writingViewController = self.presentingViewController as? WritingViewController else {return}
            writingViewController.selectedImage = self.selectedImages
            
            self.dismiss(animated: true)
        }
        
        navigationBarView.addSubview(daangnNaviBar)
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didTakeAPicture),
                                               name: Notification.Name("DidTakeAPictureNotification"),
                                               object: nil)
    }
    
    //MARK: - @objc Method
    @objc private func didTakeAPicture(){
        guard let daangnNaviBar = navigationBarView.subviews.first as? DaangnNaviBar else {return}
        daangnNaviBar.doneButton.sendActions(for: .touchUpInside)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Extension CollectionView
extension ImagePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellSize = width * (123/375)
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

extension ImagePickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = images.isEmpty ? 0 : images.count
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.configureCell(images[indexPath.row])
        
        return cell
    }
}

extension ImagePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openCamera()
        }
    }
}

extension ImagePickerViewController: ImageCollectionViewCellDelegate {
    func didSelectCountButton(_ cell: ImageCollectionViewCell) {
        if images[cell.index].selectedNumber != nil {
            guard let selectedNumber = images[cell.index].selectedNumber else {return}
            selectedImages.remove(at: selectedNumber - 1)
            
            if selectedNumber <= selectedImages.count {
                images = images.map{
                    guard var number = $0.selectedNumber else {return ImageData(image: $0.image, selectedNumber: nil)}
                    if number > selectedNumber {
                        number -= 1
                    }
                    return ImageData(image: $0.image, selectedNumber: number)
                }
            }
            
            images[cell.index].selectedNumber = nil
        } else {
            let image = images[cell.index].image
            selectedImages.append(image)
            images[cell.index].selectedNumber = selectedImages.count
        }
        imageCollectionView.reloadData()
    }
}

