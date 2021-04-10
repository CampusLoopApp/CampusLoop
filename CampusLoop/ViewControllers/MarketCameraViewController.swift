//
//  MarketCameraViewController.swift
//  CampusLoop
//
//  Created by Okwuolisa Umeokolo on 4/10/21.
//

import UIKit
import Parse

class MarketCameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Product")
        
        post["seller"] = PFUser.current()!
        post["product_name"] = productName.text!
        post["price"] = price.text!
        post["description"] = productDescription.text!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }
            else{
                print("error")
            }
        }
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        print("onCameraButton selected")
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            print(".camera")
        } else{
            picker.sourceType = .photoLibrary
            print(".photoLibrary")
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
