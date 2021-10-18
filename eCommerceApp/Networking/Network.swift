//
//  Network.swift
//  eCommerceApp
//
//  Created by Selcuk on 12.10.2021.
//

import Firebase


// retrieve data from firebase database

struct PostService{
    static let shared = PostService()
    let dbref = Database.database().reference()
    
    func fetchAllData(completion:@escaping([MyProduct]) -> Void){
        var allProduct = [MyProduct]()
        
        dbref.child("product-items").observe(.childAdded){
            (snapshot) in fetchSingleItem(id: snapshot.key){
                (item) in allProduct.append(item)
                completion(allProduct)
            }
        }
    }
    
    func fetchSingleItem(id:String,completion: @escaping(MyProduct) ->Void ){
        dbref.child("product-items").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            let myProduct = MyProduct(keyID: id, dictionary: dictionary)
            completion(myProduct)
            print(myProduct)
        }
    }
    
    func addProduct(myProduct: MyProduct ,completion: @escaping(Error?, DatabaseReference) -> Void){
        let myProductItem = ["productName":myProduct.productName,
                             "productPrice":myProduct.productPrice,
                             "productDate":myProduct.productDate,
                             "productDescription":myProduct.productDescription,
                             "productCategory":myProduct.productCategory,
                             "productImageUrl":myProduct.productImageUrl,
                             "productId":myProduct.productId] as [String:Any]
        
        let id = dbref.child("product-items").childByAutoId()
        

        id.updateChildValues(myProductItem,withCompletionBlock:completion)
        
        
        id.updateChildValues(myProductItem){
            (err,ref) in
            let myValue = ["productId": id.key!]
            dbref.child("product-items").child(id.key!).updateChildValues(myValue,withCompletionBlock: completion)
        }
   
    }
    
    func deleteProduct(id:String,completion: @escaping(Error?, DatabaseReference)->Void){
        
        dbref.child(id).setValue(nil)
        
    }
}

