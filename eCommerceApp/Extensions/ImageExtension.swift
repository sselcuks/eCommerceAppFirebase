//
//  ProductForm.swift
//  eCommerceApp
//
//  Created by Selcuk on 15.10.2021.
//


import UIKit
import Kingfisher

// fetch the image from url
extension UIImageView{
    func setImage(imageUrl:String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
