//
//  ProductModel.swift
//  eCommerceApp
//
//  Created by Selcuk on 12.10.2021.
//

import Foundation

// Database Model

struct MyProduct{
    var productName: String
    var productPrice: String
    var productDate: String
    var productDescription: String
    var productCategory: String
    var productImageUrl:String
    var productId:String
    init(keyID: String, dictionary: [String: Any]){
        self.productName = dictionary["productName"] as? String ?? ""
        self.productPrice = dictionary["productPrice"] as? String ?? ""
        self.productDate = dictionary["productDate"] as? String ?? ""
        self.productDescription = dictionary["productDescription"] as? String ?? ""
        self.productCategory = dictionary["productCategory"] as? String ?? ""
        self.productImageUrl = dictionary["productImageUrl"] as? String ?? ""
        self.productId = dictionary["productId"] as? String ?? ""
    }
    
}
