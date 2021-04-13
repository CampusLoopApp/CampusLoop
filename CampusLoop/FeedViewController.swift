//
//  FeedViewController.swift
//  CampusLoop
//
//  Created by Sonali Reddy on 4/11/21.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    struct postsStruct {
        static var posts = [PFObject]()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                FeedViewController.postsStruct.posts = posts!
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedViewController.postsStruct.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = FeedViewController.postsStruct.posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = FeedViewController.postsStruct.posts[indexPath.section]
        
        let comment = PFObject(className: "Comments")
        comment["text"] = "this is a random comment"
        comment["post"] = post
        
        comment["author"] = PFUser.current()!
        post.add(comment, forKey: "comments")
        
        post.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            }
            
            else {
                print("error saving comment")
                
            }
        }
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = FeedViewController.postsStruct.posts[indexPath.row]
        
        let detailsViewController = segue.destination as! CommentsViewController
        
        detailsViewController.post = post
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   

}
