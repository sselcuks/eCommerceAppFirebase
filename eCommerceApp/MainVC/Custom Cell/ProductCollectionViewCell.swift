//
//  ProductCollectionViewCell.swift
//  eCommerceApp
//
//  Created by Selcuk on 13.10.2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    // collectionview cell design
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLbl: UILabel!
    

    var myProducts : MyProduct?{
        didSet{
            productNameLbl.text = myProducts?.productName
            productImage.setImage(imageUrl: myProducts!.productImageUrl ?? "")
            productPriceLbl.text = myProducts?.productPrice
            productPriceLbl.text = "\(myProducts!.productPrice) TL"
        }
    }
    
}
