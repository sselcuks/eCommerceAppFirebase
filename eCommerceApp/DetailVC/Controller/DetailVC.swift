//
//  DetailVC.swift
//  eCommerceApp
//
//  Created by Selcuk on 14.10.2021.
//

import Foundation
import UIKit
import Firebase

class DetailVC:UITableViewController{
    
    @IBOutlet weak var productImgDetail: UIImageView!
    @IBOutlet weak var productNameDetail: UILabel!
    @IBOutlet weak var productPriceDetail: UILabel!
    @IBOutlet weak var productDescDetail: UITextView!
    @IBOutlet weak var productCategoryDetail: UILabel!
    @IBOutlet weak var productDateDetail: UILabel!
    var myProducts = MyProduct(keyID: "", dictionary: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setView()
        productDescDetail.layer.borderWidth = 1.0
        productImgDetail.layer.borderWidth = 1.4
        productDescDetail.layer.borderColor = UIColor.gray.cgColor
        productImgDetail.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setView(){
        productNameDetail.text = myProducts.productName
        productDescDetail.text = myProducts.productDescription
        //productPriceDetail.text = myProducts.productPrice
        productPriceDetail.text = "\(myProducts.productPrice) TL"
        productImgDetail.setImage(imageUrl: myProducts.productImageUrl)
        productCategoryDetail.text = "Ürün Kategorisi : \(myProducts.productCategory)"
        productDateDetail.text = "Ürün Ekleme Tarihi : \(myProducts.productDate)"
    }
}

