//
//  ImagePickerViewController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/14.
//

import Foundation
import UIKit

class ImagePickerViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var selectedImages: [UIImage] = []
    var images = SampleData.sample
    
    let imageViewPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        images.insert(SampleData(image: "ios_list_camera", selectedNumber: nil),at: 0)
        
        imageCollectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
        self.imageViewPicker.delegate = self
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
        return SampleData.sample.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.configureCell(images[indexPath.row]) //TODO: - 사진을 받아올 때 수정할 예정
        
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
                    guard var number = $0.selectedNumber else {return SampleData(image: $0.image, selectedNumber: nil)}
                    if number > selectedNumber {
                        number -= 1
                    }
                    return SampleData(image: $0.image, selectedNumber: number)
                }
            }
            
            images[cell.index].selectedNumber = nil
        } else {
            guard let image = UIImage(named: images[cell.index].image) else {return}
            selectedImages.append(image)
            images[cell.index].selectedNumber = selectedImages.count
        }
        imageCollectionView.reloadData()
    }
}

