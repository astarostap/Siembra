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
import MessageUI

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate  {

    
    @IBOutlet var subject: UITextField!

    @IBOutlet var message: UITextView!
    
    @IBAction func sendMessage(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            if let subjectTitle = subject.text,
                let bodyMessage = message.text {
                    picker.setSubject(subjectTitle)
                    picker.setMessageBody(bodyMessage, isHTML: true)
                    picker.setToRecipients(["qperrot@stanford.com"])
                    self.presentViewController(picker, animated: true, completion: nil)
            }
        } else {
            let cannotSendMailAlert = UIAlertController(title: "Cannot send Mail", message: "There is an issue with your device", preferredStyle:  UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            cannotSendMailAlert.addAction(cancel)
            self.presentViewController(cannotSendMailAlert, animated: true, completion: nil)
        }
    }
    
    // Using elements from this tutorial http://www.ioscreator.com/tutorials/send-email-tutorial-ios8-swift
    // MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //UITextViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        message.text = textView.text
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
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
        
        // Login functions
        var loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.frame = CGRectMake(100, 400, 150, 40)
        self.view.addSubview(loginButton)
        
        // Mail functions
        subject.delegate = self
        message.delegate = self
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
