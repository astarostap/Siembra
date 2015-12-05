//
//  LogoObjectBehavior.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit


//This code is mostly from class

class LogoObjectBehavior: UIDynamicBehavior {
    // made this public in Lecture 15
    // so that we could change the direction of the gravity
    // to match "real world" gravity we get from the accelerometer
    let gravity = UIGravityBehavior()
    
    private let collision: UICollisionBehavior = {
        let cb = UICollisionBehavior()
        cb.translatesReferenceBoundsIntoBoundary = true
        return cb
    }()
    
    // we also changed the elasticity and friction, etc.
    // in Lecture 15 because our bouncer is a free and easy bouncing view
    private let itemBehavior: UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 1
        dib.friction = 0.0
        dib.resistance = 0.0
        return dib
    }()
    
    func addBarrier(path: UIBezierPath?, named name: String) {
        collision.removeBoundaryWithIdentifier(name)
        if path != nil {
            collision.addBoundaryWithIdentifier(name, forPath: path!)
        }
    }
    
    override init() {
        super.init()
        //addChildBehavior(gravity)
        addChildBehavior(collision)
        addChildBehavior(itemBehavior)
    }
    
    func addItem(item: UIDynamicItem) {
        gravity.addItem(item)
        collision.addItem(item)
        itemBehavior.addItem(item)
        itemBehavior.addLinearVelocity(CGPoint(x: 200, y: 200), forItem: item)
    }
    
    func removeItem(item: UIDynamicItem) {
        gravity.removeItem(item)
        collision.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
