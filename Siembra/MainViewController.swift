//
//  MainViewController.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/2/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITabBarController {
    
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Tab bar appearance
        launchDatabase()
        let appearance = UITabBar.appearance()
        appearance.tintColor = UIColor(netHex:0xD5AFFF)
        appearance.barTintColor = UIColor.blackColor()
        
        let tabBarController :UITabBarController  = self
        
        let tabBar :UITabBar = tabBarController.tabBar
        let tabBarItem1 :UITabBarItem = (tabBar.items![0]) //search
        let tabBarItem2 :UITabBarItem = (tabBar.items![1]) //home
        let tabBarItem3 :UITabBarItem = (tabBar.items![2]) //you
        
        let searchImage: UIImage = UIImage(named: "rsz_2search.png")!
        tabBarItem3.image = searchImage
        
        let homeImage: UIImage = UIImage(named: "rsz_home.png")!
        //tabBarItem2.image = homeImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarItem1.image = homeImage
        
        let heartImage: UIImage = UIImage(named: "rsz_heart.png")!
        tabBarItem2.image = heartImage
        // Do any additional setup after loading the view.
        
        // Set settings 
        print("set all default settings")
        defaults.setObject(0, forKey: "vibrationMode")
        defaults.setObject(0, forKey: "parentMode")
        defaults.setObject(12, forKey: "fontSize")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Core Data
    
    ///////////////////////
    /// Hard Coded Data ///
    ///////////////////////
    
    // User Data
    private var users: [String] = ["Lisa", "Hannah"]
    
    private var usersToAddress: [String: String] = ["Lisa": "Stanford, CA, USA", "Hannah": "Stanford, CA, USA"]
    
    // Story Data
    
    private var usersToStories: [String: [String]] = ["Lisa": ["a_kiss_is_but_a_kiss", "brazen", "old_ghosts"], "Hannah": ["return_to_paradise", "staring_me_in_the_face", "three_letters"]]
    
    private var storiesToInfo: [String: [String: String]] =
    ["a_kiss_is_but_a_kiss": ["audio": "audioFileName", "image": "imageFileName", "genre": "Romantic", "title": "A Kiss Is But A Kiss", "storyDescription": "A story of love and fiery romance", "isCompleted": "true", "narratorName": "Siembra Narrator"],
        "brazen": ["audio": "audioFileName", "image": "imageFileName", "genre": "Thriller", "title": "Brazen", "storyDescription": "A story of great pursuit and excitement", "isCompleted": "false", "narratorName": "Siembra Narrator"],
        "old_ghosts": ["audio": "audioFileName", "image": "imageFileName", "genre": "Melancholic", "title": "Old Ghosts", "storyDescription": "Chasing away all those past heartbreaks", "isCompleted": "false", "narratorName": "Siembra Narrator"],
        "return_to_paradise": ["audio": "audioFileName", "image": "imageFileName", "genre": "Romantic", "title": "Return To Paradise", "storyDescription": "When that love escapes, and you want to go back", "isCompleted": "true", "narratorName": "Siembra Narrator"],
        "staring_me_in_the_face": ["audio": "audioFileName", "image": "imageFileName", "genre": "Sexy", "title": "Staring Me In The Face", "storyDescription": "Being so close yet so far", "isCompleted": "false", "narratorName": "Siembra Narrator"],
        "three_letters": ["audio": "audioFileName", "image": "imageFileName", "genre": "Beauty", "title": "Three Letters", "storyDescription": "A story of three close friends brought closer", "isCompleted": "false", "narratorName": "Siembra Narrator"]]
    
    // Contribution Data
    
    private var usersToContributedStory: [String: [String]] = ["Hannah": ["a_kiss_is_but_a_kiss", "brazen", "old_ghosts"], "Lisa": ["return_to_paradise", "staring_me_in_the_face", "three_letters"]]
    private var storyToContributions: [String: [String]] = ["a_kiss_is_but_a_kiss": ["a_kiss_is_but_a_kiss_c1"],
        "brazen": ["brazen_c1"],
        "old_ghosts": ["old_ghosts_c1", "old_ghosts_c2"],
        "return_to_paradise": ["return_to_paradise_c1"],
        "staring_me_in_the_face": ["staring_me_in_the_face_c1"],
        "three_letters": ["three_letters_c1", "three_letters_c2", "three_letters_c3"]]
    
    // Character Data
    
    private var storyToCharacters: [String: [String]] = ["a_kiss_is_but_a_kiss": ["Paul"],
        "brazen": ["Stephanie", "Courtney"],
        "old_ghosts": ["Jim", "Ellen"],
        "return_to_paradise": ["Lisa", "James"],
        "staring_me_in_the_face": ["Leanna", "Mark"],
        "three_letters": ["Rahel"]]
    
    private var characterDescriptions: [String: String] = ["Rahel": "A brave woman, a fan of mugs and a lover of politics",
        "Leanna": "She talks a lot, has a knack for reading people, and can fill a room",
        "Mark": "A man of his word until the pressure builds enough to make him reword",
        "Lisa": "Married to James in a simple dress, her life is more complex",
        "James": "Dark hair and stormy heart, he goes through life looking over his shoulder",
        "Jim": "Loves to celebrate all things but his birthday",
        "Ellen": "A young demoiselle who has a big heart, but oh so vulnerable",
        "Stephanie": "She loves cats, grabbing a book to read on the porch while enjoying a good beer",
        "Courtney": "A man eater if there ever was one, she hunts the town every weekend",
        "Paul": "Not so good with words, but can lift you off your feet when he wants -- charm abounds"]
    
    
    //////////////////////////////
    /// End of Hard Coded Data ///
    //////////////////////////////
    
    private func launchDatabase() {
        if let context = AppDelegate.managedObjectContext {
            context.performBlock {
                
                // Check if there is a need to add to Database
                let request = NSFetchRequest(entityName: "User")
                request.predicate = NSPredicate(format: "name = %@", self.users[0])
                if let _ = (try? context.executeFetchRequest(request))?.first as? User {
                    // If enters condition, then database has been launched and loaded already
                    // Ignore else statement
                    
                    // If nothing has been put in the database yet, then add everything
                } else {
                    
                    // Load up Users
                    print("will add users")
                    self.userLoader(inManagedObjectContext: context)
                    
                    // Load up Stories
                    self.storyLoader(inManagedObjectContext: context)
                    
                    // Load up Contributions
                    self.contributionLoader(inManagedObjectContext: context)
                    
                    // Load up Characters
                    self.characterLoader(inManagedObjectContext: context)
                }
                
                // Once changes have been made, save database
                do {
                    try context.save()
                } catch let error {
                    print("Core Data Erorr: \(error)")
                }
                
                // Check if database is well populated
                // Users (2)
                let request1 = NSFetchRequest(entityName: "User")
                if let users = (try? context.executeFetchRequest(request1)) as? [User] {
                    print("Number of Users: \(users.count)")
                }
                // Stories (6)
                let request2 = NSFetchRequest(entityName: "Story")
                if let stories = (try? context.executeFetchRequest(request2)) as? [Story] {
                    print("Number of Stories: \(stories.count)")
                }
                // Contributions (9)
                let request3 = NSFetchRequest(entityName: "Contribution")
                if let contributions = (try? context.executeFetchRequest(request3)) {
                    print("Number of Contributions: \(contributions.count)")
                }
                // Characters (10)
                let request4 = NSFetchRequest(entityName: "Character")
                if let characters = (try? context.executeFetchRequest(request4)) as? [Character] {
                    print("Number of Characters: \(characters.count)")
                }
            }
        }
    }
    
    private func characterLoader(inManagedObjectContext context: NSManagedObjectContext) {
        for story in storyToCharacters.keys {
            if let characters = storyToCharacters[story] {
                for characterName in characters {
                    let characterDescription = characterDescriptions[characterName]
                    if let newCharacter = NSEntityDescription.insertNewObjectForEntityForName("Character", inManagedObjectContext: context) as? Character {
                        
                        // Load character's attributes
                        newCharacter.name = characterName
                        newCharacter.personaDescription = characterDescription
                        newCharacter.mainStory = Story.findStory(story, inManagedObjectContext: context)
                        // print("Character story: \(newCharacter.name) + \(newCharacter.mainStory)")
                        // print("Character: \(newCharacter.name)")
                        // print("Character: \(newCharacter.personaDescription)")
                    }
                }
            }
        }
    }
    
    private func contributionLoader(inManagedObjectContext context: NSManagedObjectContext) {
        for user in usersToContributedStory.keys {
            if let storiesContributed = usersToContributedStory[user] {
                for storyFileName in storiesContributed {
                    if let contributions = storyToContributions[storyFileName] {
                        for contributionFileName in contributions {
                            if let newContribution = NSEntityDescription.insertNewObjectForEntityForName("Contribution", inManagedObjectContext: context) as? Contribution {
                                do {
                                    let text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource(contributionFileName, ofType: "txt")!, encoding: NSUTF8StringEncoding)
                                    
                                    // Load contribution's attributes
                                    newContribution.text = String(text)
                                    newContribution.writer = User.findUser(user, inManagedObjectContext: context)
                                    newContribution.mainStory = Story.findStory(storyFileName, inManagedObjectContext: context)
                                    
                                    //print("New Contribution: \(newContribution.text)")
                                } catch  {
                                    // Ignore
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func storyLoader(inManagedObjectContext context: NSManagedObjectContext) {
        let textTitles1 = usersToStories[self.users[0]]
        let textTitles2 = usersToStories[self.users[1]]
        
        // Create stories for first user
        for var i = 0; i < 3; i++ {
            do {
                let textFileName = textTitles1![i]
                let text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource(textFileName, ofType: "txt")!, encoding: NSUTF8StringEncoding)
                if let story = NSEntityDescription.insertNewObjectForEntityForName("Story", inManagedObjectContext: context) as? Story {
                    
                    // Load story's attributes
                    story.textFileName = textFileName
                    story.text = String(text)
                    story.title = self.storiesToInfo[textFileName]!["title"]
                    story.genre = self.storiesToInfo[textFileName]!["genre"]
                    story.storyDescription = self.storiesToInfo[textFileName]!["storyDescription"]
                    if self.storiesToInfo[textFileName]!["isCompleted"] == "true" { story.isCompleted = true} else { story.isCompleted = false }
                    story.narratorName = self.storiesToInfo[textFileName]!["narratorName"]
                    story.writer = User.findUser(users[0], inManagedObjectContext: context)
                    
                    //print("storyText: \(story.text)")
                    //print("storyTitle: \(story.title)")
                    //print("storyGenre: \(story.genre)")
                    
                }
            } catch {
                // Ignore
            }
        }
        
        // Create stories for second user
        for var i = 0; i < 3; i++ {
            do {
                let textFileName = textTitles2![i]
                let text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource(textFileName, ofType: "txt")!, encoding: NSUTF8StringEncoding)
                if let story = NSEntityDescription.insertNewObjectForEntityForName("Story", inManagedObjectContext: context) as? Story {
                    
                    // Load story's attributes
                    story.textFileName = textFileName
                    story.text = String(text)
                    story.title = self.storiesToInfo[textFileName]!["title"]
                    story.genre = self.storiesToInfo[textFileName]!["genre"]
                    story.storyDescription = self.storiesToInfo[textFileName]!["storyDescription"]
                    if self.storiesToInfo[textFileName]!["isCompleted"] == "true" { story.isCompleted = true} else { story.isCompleted = false }
                    story.narratorName = self.storiesToInfo[textFileName]!["narratorName"]
                    story.writer = User.findUser(users[1], inManagedObjectContext: context)

                    
                    //print("storyText: \(story.text)")
                    //print("storyTitle: \(story.title)")
                    //print("storyGenre: \(story.genre)")
                }
            } catch {
                // Ignore
            }
        }
    }
    
    
    
    private func userLoader(inManagedObjectContext context: NSManagedObjectContext) {
        for (userName, userAddress) in usersToAddress {
            var count = 0
            if let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as? User {
                
                // Load user's attributes
                user.id = count
                user.name = userName
                user.address = userAddress
                count++
            }
        }
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
