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


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

//    override func viewWillAppear(animated: Bool) {
//        if (FBSDKAccessToken.currentAccessToken() == nil) {
//            print("user is NOT logged in")
//        } else {
//            //self.performSegueWithIdentifier("SuccessfullLogin", sender: nil)
//            print("user IS logged in")
//        }
//    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        self.performSegueWithIdentifier("SuccessfullLogin", sender: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.frame = CGRectMake(100, 100, 150, 40)
        self.view.addSubview(loginButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    @IBAction func SignIn(sender: UIButton) {
//        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"],
//            block: { (user: PFUser?, error: NSError?) -> Void in
//                if (error != nil) {
//                    //display error message
//                    let alert = UIAlertController(title:"Alert", message: error?.localizedDescription,
//                        preferredStyle: UIAlertControllerStyle.Alert)
//                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
//                    alert.addAction(okAction)
//                    self.presentViewController(alert, animated: true, completion: nil)
//                    return
//                }
//                if (FBSDKAccessToken.currentAccessToken() != nil) {
//                    //segue
//                    print("userrrrr")
//                    print(user?.email)
//                    print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
//                    print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
//                    self.performSegueWithIdentifier("SuccessfullLogin", sender: sender)
//                }
//            }
//        )
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
