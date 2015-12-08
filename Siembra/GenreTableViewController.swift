//
//  GenreTableViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

//Table that shows entries for a given genre
class GenreTableViewController: UITableViewController {
    
    var stories: [Story] = [Story]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GenreCell", forIndexPath: indexPath)
        cell.textLabel?.text = stories[indexPath.row].title
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.detailTextLabel?.text = stories[indexPath.row].storyDescription

        cell.backgroundColor = coloredCells(indexPath.row)
        return cell
    }
    
    func coloredCells(index: Int) -> UIColor {
        let val = (CGFloat(index) / CGFloat(stories.count)) * 0.7
        return UIColor(red: val, green: 0.0, blue: 1.0, alpha: 0.1)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let storyViewController = segue.destinationViewController as? AudioViewController {
            if let cell = sender as? UITableViewCell {
                let title = cell.textLabel?.text
                if let context = AppDelegate.managedObjectContext {
                    if let story = Story.findStoryByTitle(title!, inManagedObjectContext: context) {
                        storyViewController.fileText = story.text!
                        storyViewController.storyHeaderText = story.title!
                    }
                }
            }
        }
    }


}
