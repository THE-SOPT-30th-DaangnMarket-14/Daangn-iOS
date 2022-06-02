//
//  ImagePickerViewController+.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/05/19.
//

import UIKit
import Photos

//MARK: - Camera Usage
extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imageViewPicker.sourceType = .camera
            present(imageViewPicker, animated: true)
        }else {
            print("Camera not Available")
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate Method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            selectedImages.append(image)
            NotificationCenter.default.post(name: Notification.Name("DidTakeAPictureNotification"), object: nil)
        }
        dismiss(animated: true)
    }
    
}

//MARK: - Photo Library Usage
extension ImagePickerViewController {
    func requestAccessPhotoLibrary() {
        //TODO: - 권한에 따른 추가 처리 필요
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            fetchPhotos()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite){ status in
                switch status {
                case .restricted:
                    return
                case .denied:
                    return
                case .authorized:
                    self.fetchPhotos()
                case .limited:
                    return
                case .notDetermined:
                    return
                @unknown default:
                    return
                }
            }
        case .restricted:
            return
        case .denied:
            return
        case .limited:
            return
        @unknown default:
            return
        }
    }
    
    private func fetchPhotos(){
        let sortDesriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [sortDesriptor]
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOption)
        
        DispatchQueue.global().async {
            assets.enumerateObjects{ asset, index, stop in
                let size = CGSize(width: 123, height: 123)
                let imageManager = PHImageManager.default()
                let requestOption = PHImageRequestOptions()
                
                imageManager.requestImage(for: asset,
                                          targetSize: size,
                                          contentMode: .aspectFit,
                                          options: requestOption)
                { image, resultInfo in
                    let isDegraded = (resultInfo?[PHImageResultIsDegradedKey] as? Bool) ?? false
                    if isDegraded {return}

                    guard let image = image else {return}
                    self.images.append(ImageData(image: image))

                    DispatchQueue.main.async {
                        self.imageCollectionView.reloadData()
                    }
                }
            }
        }
    }
}
