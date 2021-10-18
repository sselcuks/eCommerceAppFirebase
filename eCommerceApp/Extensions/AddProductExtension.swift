//
//  LayoutDesign.swift
//  eCommerceApp
//
//  Created by Selcuk on 15.10.2021.
//

import Foundation
import UIKit

extension AddProduct{
    
    func layoutDesign(){
        productDescription.layer.borderWidth = 0.3
        productDescription.layer.borderColor = UIColor.lightGray.cgColor
        productDescription.layer.cornerRadius = 6
    
    }
}
extension AddProduct: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            productPhoto = selectedImage
            productImage!.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

