//
//  Character+CoreDataProperties.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Character {

    @NSManaged var image: String?
    @NSManaged var name: String?
    @NSManaged var personaDescription: String?
    @NSManaged var mainStory: Story?

}
