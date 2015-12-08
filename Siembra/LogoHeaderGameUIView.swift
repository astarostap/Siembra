//
//  LogoHeaderGameUIView.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/4/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class LogoHeaderGameUIView: UIView {

    private let logoBehavior = LogoObjectBehavior()
    
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    
    private var logoView: UIImageView = UIImageView()
    
    var lines = [UIBezierPath]()
    
    func clean() {
        lines = [UIBezierPath]()
        self.setNeedsDisplay()
    }
    
<<<<<<< HEAD
=======
    private var paddle: UIView = UIView()
    
>>>>>>> 7dc9883449dc76bb9efdf81329cef8f83fc28e9f
    func addLogo() {
        let logoImage = UIImage(named: "29pt_logo.png")
        logoView = UIImageView()
        logoView.image = logoImage
        logoView.frame = CGRectMake(self.bounds.size.width / 2 - 30, 10 , logoImage!.size.width, logoImage!.size.height)
        addSubview(logoView)
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.purpleColor().setStroke()
        addLogo()
        
        for line in lines {
            line.lineWidth = 10
            line.stroke()
        }
    }
    
    func startAnimation(){
        logoBehavior.addItem(logoView)
        animator.addBehavior(logoBehavior)
    }
    
    func setUpDrawingGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapScreen:"))
        self.addGestureRecognizer(tapGesture)
    }
    
    var start: CGPoint?
    var end: CGPoint?
    
    func tapScreen(tapGesture: UITapGestureRecognizer) {
        let tappedPoint = tapGesture.locationInView(self)
        let x = tappedPoint.x
        let y = tappedPoint.y
        
        if (start == nil) {
            start = CGPoint(x: x, y: y)
        } else {
            end = CGPoint(x: x, y: y)
    
            let line = UIBezierPath()
            line.moveToPoint(start!)
            line.addLineToPoint(end!)
            
            lines.append(line)
            start = nil
            end = nil
            
            self.setNeedsDisplay()
        }
    }
    
}
