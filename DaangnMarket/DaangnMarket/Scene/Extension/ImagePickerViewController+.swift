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
        }
        dismiss(animated: true)
    }
    
}

//MARK: - Photo Library Usage
extension ImagePickerViewController {
    func requestAccessPhotoLibrary() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite){ status in
                switch status {
                case .notDetermined:
                    return
                case .restricted:
                    return
                case .denied:
                    return
                case .authorized:
                    return
                case .limited:
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
}
