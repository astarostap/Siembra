//
//  Story+CoreDataProperties.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/7/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Story {

    @NSManaged var authorName: String?
    @NSManaged var dateCreated: NSDate?
    @NSManaged var genre: String?
    @NSManaged var image: String?
    @NSManaged var isCompleted: NSNumber?
    @NSManaged var narratorName: String?
    @NSManaged var storyDescription: String?
    @NSManaged var text: String?
    @NSManaged var textFileName: String?
    @NSManaged var title: String?
    @NSManaged var audioFileName: String?
    @NSManaged var characters: NSSet?
    @NSManaged var contributions: NSSet?
    @NSManaged var narrationFollowers: NSSet?
    @NSManaged var storyFollowers: NSSet?
    @NSManaged var writer: User?

}
