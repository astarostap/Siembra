//
//  StoryContributionViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class StoryContributionViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Set number of minutes picked
        let timePicked = datePicker.date
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: timePicked)
        let hour = Int(comp.hour)
        let minute = Int(comp.minute)
        let totalMinutes = 60 * hour + minute
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(totalMinutes, forKey: "sessionNumMinutes")
        
        //Set current time so we can later check if it's within bounds
        let currTime = NSDate()
        defaults.setObject(currTime, forKey: "sessionStarted")
        print(timePicked)
    }


}
