//
//  StoryContributionViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import Foundation

class StoryContributionViewController: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var storyName: String?
    // Use story name to get story to add contribution to
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importAction()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func plantChallenge(sender: UIButton) {
        print("entered")
        //Set number of minutes picked
        let timePicked = datePicker.date
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: timePicked)
        let hour = Int(comp.hour)
        let minute = Int(comp.minute)
        let totalMinutes = 60 * hour + minute
        
        // Set notifications 
        let localNotificaiton = UILocalNotification()
        localNotificaiton.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(totalMinutes * 60))
        localNotificaiton.alertBody = "Your challenge timer is over! Check if someone posted a contribution."
        localNotificaiton.timeZone = NSTimeZone.defaultTimeZone()
        localNotificaiton.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotificaiton)
        
        // Create alert
        let alert = UIAlertController(title: nil, message: "You have set up a community challenge! Time is now ticking...", preferredStyle: .ActionSheet)
        let okay = UIAlertAction(title: "Continue", style: UIAlertActionStyle.Cancel, handler:nil)
        alert.addAction(okay)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    private func importAction() {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.text"], inMode: UIDocumentPickerMode.Import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        self.presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    var newContribution: String = ""
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        if controller.documentPickerMode == UIDocumentPickerMode.Import {
            if let text = try? String(contentsOfFile: url.path!) {
                self.newContribution = text
                print("new: \(self.newContribution)")
                if let context = AppDelegate.managedObjectContext {
                    if let story = Story.findStoryByTitle(storyName!, inManagedObjectContext: context) {
                        story.text! += " " + text
                        print(story.text!)
                    }
                }
            }
        }
        
        let alert = UIAlertController(title: nil, message: "You have successfully chosen a file from iCloud!", preferredStyle: .ActionSheet)
        let cancelChoice = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler:nil)
        alert.addAction(cancelChoice)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


}
