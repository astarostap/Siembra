//
//  User.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/2/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {

    // Given the user's name, returnt the User entity
    class func findUser(userName: String, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let request = NSFetchRequest(entityName: "User")
        request.predicate = NSPredicate(format: "name = %@", userName)
        if let user = (try? context.executeFetchRequest(request))?.first as? User {
            return user
        }
        return nil
    }
}
