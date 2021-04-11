//
//  ProductDetailsViewController.swift
//  CampusLoop
//
//  Created by Okwuolisa Umeokolo on 4/6/21.
//

import UIKit
import Parse

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productNameLabel.text = product!["product_name"] as? String
        productNameLabel.sizeToFit()
        descriptionLabel.text = product!["description"] as? String
        descriptionLabel.sizeToFit()
        priceLabel.text = product!["price"] as? String
        priceLabel.sizeToFit()
        sellerNameLabel.text = product!["seller"] as? String
        sellerNameLabel.sizeToFit()
        
        let userImageFile = product!["image"] as! PFFileObject
        userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
            if (error == nil) {
                self.posterImage.image = UIImage(data: imageData!)
            } else {
                let placeholderImage: UIImage = UIImage(named: "Placeholder_Image")!
                self.posterImage.image = placeholderImage
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
