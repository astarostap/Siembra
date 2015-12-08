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
import AudioToolbox


class UserSettingsViewController: UIViewController, FBSDKLoginButtonDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate  {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // Setting outlets, corresponding to the font size, the two switches, and the stepper.
    @IBOutlet weak var fontSizeLabel: UILabel!
    
    @IBOutlet var vibrationSwitch: UISwitch!
    
    @IBOutlet var parentalSwitch: UISwitch!
    
    @IBOutlet var stepper: UIStepper!
    
    // This will increase the font size for the stories in the AudioViewController
    @IBAction func stepperAction(sender: UIStepper) {
        let fontSize = stepper.value
        defaults.setObject(fontSize, forKey: "fontSize")
        fontSizeLabel.text = "Story Font Size: " + String(fontSize)
        
    }
    
    // This button will turn on parental mode, which will filter through stories that are of a more R-rated nature
    @IBAction func parentalSwitchAction(sender: UISwitch) {
        var control: Int
        if (sender.on) {
            control = 1
            defaults.setObject(control, forKey: "parentMode")
        } else {
            control = 0
            defaults.setObject(control, forKey: "parentMode")
        }
    }
    
    // Will turn on vibration for a split second
    @IBAction func vibrationSwitchAction(sender: UISwitch) {
        var control: Int
        if (sender.on) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
            control = 1
            defaults.setObject(control, forKey: "vibrationMode")
        } else {
            control = 0
            defaults.setObject(control, forKey: "vibrationMode")
        }
    }
    
    // Message Sending for users to be able to contact us if they have issues
    
    @IBOutlet var subject: UITextField!
    
    @IBOutlet var message: UITextView!
    
    // This function makes a MailCompose controller which will use the text in subject and message and open up the Mail app. If the mail fails, then an alert is launched. 
    // Inspiration for this feature was taken from this tutorial http://www.ioscreator.com/tutorials/send-email-tutorial-ios8-swift
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
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        
        loginButton.frame = CGRectMake(10, 75, 150, 40)
        self.view.addSubview(loginButton)
        
        // Mail functions
        subject.delegate = self
        message.delegate = self
        
        // Defaults: load all the appropriate user defaults so users are not surprised by weird settings
        
        // Load font size
        if let value = defaults.objectForKey("fontSize") as? Double {
            stepper.value = value
            fontSizeLabel.text = fontSizeLabel.text! + String(value)
        }
        
        // Load parental mode
        if let parentDefault = defaults.objectForKey("parentMode") as? Int {
            if (parentDefault == 1) { parentalSwitch.setOn(true, animated: false) }
            if (parentDefault == 0) { parentalSwitch.setOn(false, animated: false) }
        }
        
        // Load vibration mode
        if let vibrateDefault = defaults.objectForKey("vibrationMode") as? Int {
            if (vibrateDefault == 1) { parentalSwitch.setOn(true, animated: false) }
            if (vibrateDefault == 0) { parentalSwitch.setOn(false, animated: false) }
        }
    }
}
