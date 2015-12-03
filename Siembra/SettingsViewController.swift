//
//  LogoutViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Parse
import ParseFacebookUtilsV4

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate  {



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SignOutButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("SignIn", sender: sender)
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
