//
//  SearchTableViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import CoreData
import Foundation

class SearchTableViewController: UITableViewController, UISearchResultsUpdating  {
    
    // Search elements array that contains 3 arrays where the first is users,
    // second is stories, and third is characters
    private var searchElements = [[AnyObject]]()
    
    
    /////////////////////////////
    /// Work to filter search ///
    /////////////////////////////
    
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
        }
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
