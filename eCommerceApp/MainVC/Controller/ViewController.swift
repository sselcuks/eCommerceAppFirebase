//
//  ViewController.swift
//  eCommerceApp
//
//  Created by Selcuk on 12.10.2021.
//


import UIKit

import Firebase
class ViewController: UIViewController{
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    var ref: DatabaseReference!
    
    var myProducts = [MyProduct](){
        didSet{
            print("products are set")
            productCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ürünler"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Yeni Ürün", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        productCollectionView.reloadData()
    }
    
    func deleteMyProduct(id:String){
        ref.child(id).setValue(nil)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        PostService.shared.fetchAllData { (allProduct) in
            self.myProducts = allProduct
        }
    }
    
    @objc func addTapped(){
        let storyboard = UIStoryboard(name: "AddProductVC", bundle: nil)
        let myProductList = storyboard.instantiateViewController(identifier: "AddProductVC")
        myProductList.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(myProductList,animated: true)

    }
}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
        cell.myProducts = myProducts[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //configureContextMenu(index: indexPath.row)
        let storyboard = UIStoryboard(name: "DetailVC", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as? DetailVC
        detailVC?.myProducts = myProducts[indexPath.row]
        self.navigationController?.pushViewController(detailVC!, animated: true)
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
       
            configureContextMenu(index: indexPath.row)
     
        }
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration{
       
           let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
               
               let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                  
               }
               let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
              
               }
               return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
           }
           return context
       }
}
