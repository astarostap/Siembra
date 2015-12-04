//
//  PopoverViewController.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var storyView: UITextView!
    
    var text: String = ""
    
    func setStory(storyText: String?) {
        if storyText != nil {
            text = storyText!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        storyView.text = text
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
