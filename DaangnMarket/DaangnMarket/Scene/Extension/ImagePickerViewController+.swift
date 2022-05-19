//
//  ImagePickerViewController+.swift
//  DaangnMarket
//
//  Created by 임윤휘 on 2022/05/19.
//

import UIKit

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
