//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by Eric Vandenberg on 9/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var interestedInWomen: UISwitch!
    

    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.saveInBackground()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let result = result {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                
                PFUser.currentUser()?.saveInBackground()
                
                let userId = result["id"] as! String
                
                let facebookProPicURL = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicurl = NSURL(string: facebookProPicURL) {
                 
                    if let data = NSData(contentsOfURL: fbpicurl) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["imageFile"] = imageFile
                        PFUser.currentUser()?.saveInBackground()
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
