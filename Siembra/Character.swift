//
//  Character.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/2/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import Foundation
import CoreData


class Character: NSManagedObject {

    // Given the character's name, return the Character Entity
    class func findCharacter(characterName: String, inManagedObjectContext context: NSManagedObjectContext) -> Character? {
        let request = NSFetchRequest(entityName: "Character")
        request.predicate = NSPredicate(format: "name = %@", characterName)
        if let character = (try? context.executeFetchRequest(request))?.first as? Character {
            return character
        }
        return nil
    }
}
