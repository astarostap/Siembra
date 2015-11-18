//
//  LoginViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Parse
import ParseFacebookUtilsV4


class LoginViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("user is NOT logged in")
        } else {
            self.performSegueWithIdentifier("SuccessfullLogin", sender: nil)
            print("user IS logged in")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if (FBSDKAccessToken.currentAccessToken() == nil) {
//            print("user is NOT logged in")
//        } else {
//            self.performSegueWithIdentifier("SuccessfullLogin", sender: nil)
//            print("user IS logged in")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //From https://www.youtube.com/watch?v=Iqu1bZcUnW0
    @IBAction func SignInButtonTapped(sender: UIButton) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"],
            block: { (user: PFUser?, error: NSError?) -> Void in
                if (error != nil) {
                    //display error message
                    let alert = UIAlertController(title:"Alert", message: error?.localizedDescription,
                        preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                print("userrrrr")
                print(user?.email)
                print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
                print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
                
                if (FBSDKAccessToken.currentAccessToken() != nil) {
                    //segue
                    self.performSegueWithIdentifier("SuccessfullLogin", sender: sender)
                }
            }
        )
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
