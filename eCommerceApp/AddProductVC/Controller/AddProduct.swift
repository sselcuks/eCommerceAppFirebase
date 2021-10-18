//
//  AddProduct.swift
//  eCommerceApp
//
//  Created by Selcuk on 12.10.2021.
//


import UIKit
import Firebase

class AddProduct: UITableViewController{
    @IBOutlet var productImage: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productDate: UITextField!
    @IBOutlet weak var productCategory: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    
    // image selection from gallery
    var productPhoto: UIImage? = nil
    
    var ref: DatabaseReference!
    // Firebase Storage Url
    private let storage = Storage.storage().reference(forURL: "gs://ecommerceapp-603ab.appspot.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDesign()
        ref = Database.database().reference()
    
    }
    // Add product to Firebase Database.
    @IBAction func addProducts(_ sender: UIButton) {
        setData()
    }
    
    func setData() {
        guard let selectedImage = self.productPhoto else{
            print("img not found")
            return
        }
        // compress the selected image file.
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        // add products to database
        let imageId = NSUUID().uuidString
        let myProducts = MyProduct(keyID: "", dictionary: [:])
        
        let storageProductRef = storage.child("product-images").child("\(imageId)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        storageProductRef.putData(imageData, metadata: metadata) { storageMetaData, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            // Retrieve Firebase storage image url and append with other valuesto Realtime Database.
            storageProductRef.downloadURL { url, error in
                if let metaImageUrl = url?.absoluteString {
                    self.fillData(metaImageUrl: metaImageUrl)
                    print(metaImageUrl)
                    
                }
            }
        }
    }
    
    func fillData(metaImageUrl: String) {
        var myProducts = MyProduct(keyID: "", dictionary: [:])
        myProducts.productName = self.productName.text ?? ""
        myProducts.productPrice = self.productPrice.text ?? ""
        myProducts.productDate = self.productDate.text ?? ""
        myProducts.productDescription = self.productDescription.text ?? ""
        myProducts.productCategory = self.productCategory.text ?? ""
        myProducts.productImageUrl = metaImageUrl
        
        PostService.shared.addProduct(myProduct: myProducts){
            (err,ref) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
        
    }
}

