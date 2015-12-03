//
//  Contribution+CoreDataProperties.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/2/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contribution {

    @NSManaged var text: String?
    @NSManaged var submissionTime: NSDate?

}
