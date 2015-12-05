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

    func addLogo() {
        let logoImage = UIImage(named: "29pt_logo.png")
        logoView = UIImageView()
        logoView.image = logoImage
        logoView.frame = CGRectMake(self.bounds.size.width / 2 - 5, 10 , logoImage!.size.width, logoImage!.size.height)
        addSubview(logoView)
    }
    
    func startAnimation(){
        logoBehavior.addItem(logoView)
        animator.addBehavior(logoBehavior)
    }
    
    func returnToInitialPosition() {
        //logoBehavior.removeItem(logoView)
        //logoView.removeFromSuperview()
        //logoView = UIImageView()
        //addLogo()
    }
    
}
