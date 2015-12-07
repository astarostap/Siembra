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
    
    var ctx: CGContext?

    func addLogo() {
        let logoImage = UIImage(named: "29pt_logo.png")
        logoView = UIImageView()
        logoView.image = logoImage
        logoView.frame = CGRectMake(self.bounds.size.width / 2 - 30, 10 , logoImage!.size.width, logoImage!.size.height)
        addSubview(logoView)
    }
    
    override func drawRect(rect: CGRect) {
        addLogo()
        ctx = UIGraphicsGetCurrentContext()
        
        let start = self.bounds.origin
        
        let end = CGPoint(x: start.x + self.frame.width, y: start.y + self.frame.height)
        let line = UIBezierPath()
        line.moveToPoint(start)
        line.addLineToPoint(end)
        UIColor.blackColor().setStroke()
        
        line.lineWidth = 10
        line.fill()
        line.stroke()
        //logoBehavior.addBarrier(line, named: "diagonal")
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
            let logoImage = UIImage(named: "29pt_logo.png")
            logoView = UIImageView()
            logoView.image = logoImage
            logoView.frame = CGRectMake(end!.x, end!.y, logoImage!.size.width, logoImage!.size.height)
            addSubview(logoView)
            start = nil
            end = nil
        }
    }
    
}
