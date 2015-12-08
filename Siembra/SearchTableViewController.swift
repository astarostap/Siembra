//
//  SearchTableViewController.swift
//  Siembra
//
//  Created by Quentin Perrot on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import CoreData
import Foundation
import Social

class SearchTableViewController: UITableViewController, UISearchResultsUpdating  {
    
    // Search elements array that contains 3 arrays where the first is users,
    // second is stories, and third is characters
    private var searchElements = [[AnyObject]]()
    
    
    /////////////////////////////
    /// Work to filter search ///
    /////////////////////////////
    
    
    @IBOutlet weak var segmentedValue: UISegmentedControl! {
        didSet {
            searchElements = segmentedSearchItems
        }
    }
    
    
    @IBAction func searchSegmentedControl(sender: UISegmentedControl) {
        switch segmentedValue.selectedSegmentIndex {
        case 0:
            searchElements[1].removeAll()
            searchElements[2].removeAll()
            
        case 1:
            searchElements[0].removeAll()
            searchElements[2].removeAll()
        case 2:
            searchElements[0].removeAll()
            searchElements[1].removeAll()
        case 3:
            searchElements = originalSearchItems
        default:
            searchElements = originalSearchItems
            break;
        }
        print(searchElements)
        
        // Update table
        self.tableView.reloadData()
        searchElements = originalSearchItems
    }
    
    private var originalSearchItems = [[AnyObject]]()
    
    private var segmentedSearchItems = [[AnyObject]]()
    
    private var filteredSearchItems = [[AnyObject]]()
    
    private var resultSearchController = UISearchController()
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // Filter the searchElements array using the filterMethod
        filteredSearchItems.removeAll(keepCapacity: false)
        if let searchText = searchController.searchBar.text {
            print("searchText: \(searchText)")
            
            // Filter users
            if var users = searchElements[0] as? [User] {
                users = users.filter({( user: User) -> Bool in
                    let stringMatch = user.name?.lowercaseString.rangeOfString(searchText)
                    return stringMatch != nil
                })
                filteredSearchItems.append(users)
            }
            
            // Filter stories
            if var stories = searchElements[1] as? [Story] {
                stories = stories.filter({( story: Story) -> Bool in
                    let stringMatch = story.title?.lowercaseString.rangeOfString(searchText)
                    return stringMatch != nil
                })
                filteredSearchItems.append(stories)
            }
            
            // Filter Characters
            if var characters = searchElements[2] as? [Character] {
                characters = characters.filter({( character: Character) -> Bool in
                    let stringMatch = character.name?.lowercaseString.rangeOfString(searchText)
                    return stringMatch != nil
                })
                filteredSearchItems.append(characters)
            }
        }
        // Update table
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data into searchElements
        if let context = AppDelegate.managedObjectContext {
            //print("context: \(context)")
            let request1 = NSFetchRequest(entityName: "User")
            let request2 = NSFetchRequest(entityName: "Story")
            let request3 = NSFetchRequest(entityName: "Character")
            if let users = (try? context.executeFetchRequest(request1)) as? [User],
                let stories = (try? context.executeFetchRequest(request2)) as? [Story],
                let characters = (try? context.executeFetchRequest(request3)) as? [Character] {
                    //print("Characters: \(characters)")
                    searchElements.append(users)
                    searchElements.append(stories)
                    searchElements.append(characters)
            }
            originalSearchItems = searchElements
        }
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // Style the table
        tableView.separatorStyle = .None
        tableView.rowHeight = 50.0
        
        // Reload the table
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view delegate 
    
    func coloredCells(index: Int) -> UIColor {
        var count = 0
        for array in originalSearchItems {
            count += array.count
        }
        let val = (CGFloat(index) / CGFloat(count)) * 0.7
        return UIColor(red: val, green: 0.0, blue: 1.0, alpha: 0.1)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            let section = indexPath.section
            let row = indexPath.row
            var count = 0
            for var i = 0; i < section; i++ {
                count += originalSearchItems[section].count
            }
            cell.backgroundColor = coloredCells(count + row)
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (self.resultSearchController.active) {
            return filteredSearchItems.count
        } else {
            return searchElements.count
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return filteredSearchItems[section].count
        } else {
            return searchElements[section].count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Chose the right array to populate the table view
        var activeSearchArray = [[AnyObject]]()
        if (self.resultSearchController.active) {
            activeSearchArray = filteredSearchItems
        } else {
            activeSearchArray = searchElements
        }
                
        // print("section: \(indexPath.section) row: \(indexPath.row)")
        let searchItem = activeSearchArray[indexPath.section][indexPath.row]
        //print("searchItem: \(searchItem)")
        var cell = UITableViewCell()
        switch indexPath.section {
            // User
            case 0:
                if let user = searchItem as? User {
                    cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)
                    cell.textLabel?.text = user.name
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    let numberOfContributions = (user.contributions)!.count
                    cell.detailTextLabel?.text = "A top Siembra user with \(numberOfContributions) contributions"
                }
            
            // Story
            case 1:
                if let story = searchItem as? Story {
                    cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)
                    cell.textLabel?.text = story.title
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    cell.detailTextLabel?.text = story.storyDescription
                }
            
            // Character 
            case 2:
                if let character = searchItem as? Character {
                    cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)
                    cell.textLabel?.text = character.name
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    let storyName = character.mainStory!.title
                    cell.detailTextLabel?.text = "Character in \(storyName!)"
                }
            
            default: break // do nothing
        }
        
        return cell
    }
    
    // Inspired by a tutorial on Social sharing: http://www.brianjcoleman.com/tutorial-share-facebook-twitter-swift/
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Gesture to share search items
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            let share = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            
            let cancelChoice = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil)
            
            let twitterChoice = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                    let twitterSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    var element = self.searchElements[indexPath.section][indexPath.row]
                    var message = ""
                    if (indexPath.section == 0) { element = self.checkUser(element); message = element.name }
                    if (indexPath.section == 1) { element = self.checkStory(element) as Story; message = "What a great story"}
                    if (indexPath.section == 2) { element = self.checkCharacter(element); message = element.name }
                    twitterSheet.setInitialText("Love \(message) so far -- join me on Siembra")
                    self.presentViewController(twitterSheet, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Accounts", message: "Please login into Twitter to share", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
            
            let facebookChoice = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    let facebookSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookSheet.setInitialText("Share through Facebook")
                    self.presentViewController(facebookSheet, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Accounts", message: "Please login into Facebook to share", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
            
            share.addAction(facebookChoice)
            share.addAction(twitterChoice)
            share.addAction(cancelChoice)
            self.presentViewController(share, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            let delete = UIAlertController(title: nil, message: "Are you sure you want to delete?", preferredStyle: .ActionSheet)
            let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
                self.searchElements[indexPath.section].removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
            let no = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil)
            delete.addAction(yes)
            delete.addAction(no)
            self.presentViewController(delete, animated: true, completion: nil)
        })
        
        // Change style 
        shareAction.backgroundColor = UIColor.blueColor()
        deleteAction.backgroundColor = UIColor.redColor()
        return [shareAction, deleteAction]
    }
    
    func checkUser(element: AnyObject) -> User {
        if let object = element as? User {
            return object
        }
        return User()
    }
    
    func checkCharacter(element: AnyObject) -> Character {
        if let object = element as? Character {
            return object
        }
        return Character()
    }
    
    func checkStory(element: AnyObject) -> Story {
        if let object = element as? Story {
            return object
        }
        return Story()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Sender: \(sender)")
        let destinationvc: UIViewController? = segue.destinationViewController
        if let audioViewController = destinationvc as? AudioViewController {
            //if let search = sender as? HomeVideoCell {
            var text = ""
            var title = ""
            do {
                text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("sample_story", ofType: "txt")!, encoding: NSUTF8StringEncoding) as String
            } catch {
                // Ignore
            }
            
            var indexPath: NSIndexPath
            // Get index path, which is required to know what text to pass
            if let cell = sender as? UITableViewCell {
                if let path = tableView.indexPathForCell(cell) {
                    indexPath = path
                    print("IndexPath: \(indexPath), \(indexPath.section), \(indexPath.row)")
                    
                    // Get text
                    if let context = AppDelegate.managedObjectContext {
                        switch indexPath.section {
                        case 0:
                            if let user = User.findUser((cell.textLabel?.text)!, inManagedObjectContext: context) {
                                if let stories = user.publications!.allObjects as? [Story] {
                                    if let story = stories.first {
                                        text = story.text!
                                        title = story.title!
                                    }
                                }
                            }
                        case 1:
                            if let story = Story.findStoryByTitle((cell.textLabel?.text)!, inManagedObjectContext: context) {
                                text = story.text!
                                title = story.title!
                            }
                        case 2:
                            if let story = Story.findStoryByCharacter((cell.textLabel?.text)!, inManagedObjectContext: context) {
                                text = story.text!
                                title = story.title!
                            }
                        default: break
                        }
                    }
                }
            }
            audioViewController.fileText = text
            audioViewController.storyHeaderText = title
        }
    }
    
}
