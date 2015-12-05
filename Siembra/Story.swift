//
//  Story.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/2/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import Foundation
import CoreData


class Story: NSManagedObject {

    // Given the story's file name, return the Story entity
    class func findStory(storyFileName: String, inManagedObjectContext context: NSManagedObjectContext) -> Story? {
        let request = NSFetchRequest(entityName: "Story")
        request.predicate = NSPredicate(format: "textFileName = %@", storyFileName)
        if let story = (try? context.executeFetchRequest(request))?.first as? Story {
            return story
        }
        return nil
    }
    
    // Given the story's title name, return the Story entity
    class func findStoryByTitle(storyTitle: String, inManagedObjectContext context: NSManagedObjectContext) -> Story? {
        let request = NSFetchRequest(entityName: "Story")
        request.predicate = NSPredicate(format: "title = %@", storyTitle)
        if let story = (try? context.executeFetchRequest(request))?.first as? Story {
            return story
        }
        return nil
    }
    
    // Given the story's title name, return the Story entity
    class func findStoryByCharacter(characterName: String, inManagedObjectContext context: NSManagedObjectContext) -> Story? {
        let request = NSFetchRequest(entityName: "Character")
        request.predicate = NSPredicate(format: "name = %@", characterName)
        if let character = (try? context.executeFetchRequest(request))?.first as? Character {
            let story = character.mainStory
            return story
        }
        return nil
    }
}
