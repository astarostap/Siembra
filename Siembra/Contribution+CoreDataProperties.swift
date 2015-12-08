//
//  Contribution+CoreDataProperties.swift
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

extension Contribution {

    @NSManaged var submissionTime: NSDate?
    @NSManaged var text: String?
    @NSManaged var mainStory: Story?
    @NSManaged var writer: User?

}
