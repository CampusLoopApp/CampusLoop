//
//  CommentsViewController.swift
//  CampusLoop
//
//  Created by Sharath Reddy on 4/11/21.
//

import UIKit
import Parse

class CommentsViewController: UIViewController {
    
    
   
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = post["author"] as? String
        
        captionLabel.text = post["caption"] as? String

        // Do any additional setup after loading the view.
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
