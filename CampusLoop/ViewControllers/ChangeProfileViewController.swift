//
//  ChangeProfileViewController.swift
//  CampusLoop
//
//  Created by Brylee Pavlik on 4/10/21.
//

import UIKit
import Parse
class ChangeProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //var imageToSend = UIImage()
    //var bio = ""
    
    struct profileStruct {
        static var bioText: String = ""
        static var profilePic = UIImage()
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentField: UITextField!
    
  
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = PFUser.current()!.username
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let secondVC = segue.destination as! ProfileViewController
//        secondVC.firstVCtext = bio
//        let secondVCimage = segue.destination as! ProfileViewController
//        secondVCimage.firstVCimage = imageToSend
//        print(secondVC.firstVCtext)
//    }
    
    
    @IBAction func onSubmitButton(_ sender: Any) {
        ChangeProfileViewController.profileStruct.bioText = commentField.text!
        //print(bio)
        
    }
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        ChangeProfileViewController.profileStruct.profilePic = scaledImage
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
