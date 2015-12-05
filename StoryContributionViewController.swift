//
//  StoryContributionViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

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
        
        //Set number of minutes picked
        let timePicked = datePicker.date
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: timePicked)
        let hour = Int(comp.hour)
        let minute = Int(comp.minute)
        let totalMinutes = 60 * hour + minute
        
        //Set current time so we can later check if it's within bounds
        let currTime = NSDate()
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
                    //
                }
            }
        }
        
        let alert = UIAlertController(title: nil, message: "You have chosen a contribution with filename: \(url.absoluteString)", preferredStyle: .ActionSheet)
        let cancelChoice = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler:nil)
        alert.addAction(cancelChoice)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }


}
