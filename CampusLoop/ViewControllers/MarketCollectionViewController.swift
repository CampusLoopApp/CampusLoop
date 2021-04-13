//
//  MarketCollectionViewController.swift
//  CampusLoop
//
//  Created by Okwuolisa Umeokolo on 3/30/21.
//

import UIKit
import Parse
//import AlamofireImage

private let reuseIdentifier = "ProductCell"

class MarketCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    var products = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sellProduct(_sender:)))
//
//        @objc func sellProduct(_ sender: Any) {
//           performSegue(withIdentifier: "sellProductSegue", sender: nil)
//        }
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        let query = PFQuery(className:"Product")
        query.includeKeys(["product_name", "price", "description", "seller"])
        query.limit = 20
        
        query.findObjectsInBackground { (products: [PFObject]?, error: Error?) in
            if products != nil {
                self.products = products!
                self.collectionView.reloadData()
            }
        }

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumLineSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductCell else {
            fatalError("Unable to deque ProductCell")
        }
        // Configure the cell
        let product = products[indexPath.item]
        cell.productNameLabel.text = product["product_name"] as? String
        cell.priceLabel.text = "$"
        let priceString: String = product["price"] as! String
        cell.priceLabel.text! += priceString
        let userImageFile = product["image"] as! PFFileObject
        userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
            if (error == nil) {
                cell.posterImage.image = UIImage(data: imageData!)
            } else {
                let placeholderImage: UIImage = UIImage(named: "Placeholder_Image")!
                cell.posterImage.image = placeholderImage
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let product = products[indexPath.row]
        
        // Pass the selected product to the details view controller
        let detailViewController = segue.destination as! ProductDetailsViewController
        detailViewController.product = product
        // collectionView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
