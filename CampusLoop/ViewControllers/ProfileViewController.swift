//
//  ProfileViewController.swift
//  CampusLoop
//
//  Created by Brylee Pavlik on 4/4/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let current_user = PFUser.current()!
        usernameLabel.text = current_user.username
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
