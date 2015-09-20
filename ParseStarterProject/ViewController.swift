//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit


class ViewController: UIViewController {

    @IBAction func facebookLogin(sender: AnyObject) {
        
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                
                print(error)
                
            } else {
                
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInWomen"] {
                        
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                        
                    } else {
                    
                        self.performSegueWithIdentifier("showSignInScreen", sender: self)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let username = PFUser.currentUser()?.username {
        
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
                
                self.performSegueWithIdentifier("logUserIn", sender: self)
                
            } else {
                
                self.performSegueWithIdentifier("showSignInScreen", sender: self)
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

