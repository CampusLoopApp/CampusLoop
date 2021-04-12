//
//  ProfileViewController.swift
//  CampusLoop
//
//  Created by Brylee Pavlik on 4/10/21.
//

import UIKit
import Parse
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var posts = FeedViewController.postsStruct.posts
    //var firstVCtext = ""
    //var firstVCimage: UIImage? = UIImage()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        usernameLabel.text = PFUser.current()!.username
        if (ChangeProfileViewController.profileStruct.bioText != "") {
            bioLabel.text = ChangeProfileViewController.profileStruct.bioText
        }
        else {
            bioLabel.text = "Bio"
        }
        if ChangeProfileViewController.profileStruct.profilePic.size.width == 0 {
            imageView.image = UIImage(systemName: "person.circle.fill")
        }
        else {
            imageView.image = ChangeProfileViewController.profileStruct.profilePic
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (ChangeProfileViewController.profileStruct.bioText != "") {
            bioLabel.text = ChangeProfileViewController.profileStruct.bioText
        }
        else {
            bioLabel.text = "Bio"
        }
        if ChangeProfileViewController.profileStruct.profilePic.size.width == 0 {
            imageView.image = UIImage(systemName: "person.circle.fill")
        }
        else {
            imageView.image = ChangeProfileViewController.profileStruct.profilePic
        }

        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20

        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()

            }
        }
    }
//
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for post in posts {
            let user = post["author"] as! PFUser
            if(user.username == PFUser.current()!.username) {
                count = count + 1
            }
        }
        return count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post = posts[indexPath.row]
        var user = post["author"] as! PFUser
        while (user.username != PFUser.current()!.username) {
            post = posts[indexPath.row + 1]
            user = post["author"] as! PFUser
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        

        return cell
    
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let post = posts[indexPath.section]
//
//        let comment = PFObject(className: "Comments")
//        comment["text"] = "this is a random comment"
//        comment["post"] = post
//
//        comment["author"] = PFUser.current()!
//        post.add(comment, forKey: "comments")
//
//        post.saveInBackground { (success, error) in
//            if success {
//                print("Comment saved")
//            }
//
//            else {
//                print("error saving comment")
//
//            }
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//        let post = posts[indexPath.row]
//
//        let detailsViewController = segue.destination as! CommentsViewController
//
//        detailsViewController.post = post
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
}
