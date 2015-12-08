//
//  TabBarViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    //sets up tab bar appearance
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tab bar appearance
        let appearance = UITabBar.appearance()
        appearance.tintColor = UIColor(netHex:0xD5AFFF)
        appearance.barTintColor = UIColor.blackColor()
        
        let tabBarController :UITabBarController  = self
        
        let tabBar :UITabBar = tabBarController.tabBar
        let tabBarItem1 :UITabBarItem = (tabBar.items![0]) //search
        let tabBarItem2 :UITabBarItem = (tabBar.items![1]) //home
        let tabBarItem3 :UITabBarItem = (tabBar.items![2]) //you
        
        let searchImage: UIImage = UIImage(named: "rsz_2search.png")!
        tabBarItem3.image = searchImage
        
        let homeImage: UIImage = UIImage(named: "rsz_home.png")!
        //tabBarItem2.image = homeImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarItem1.image = homeImage
        
        let heartImage: UIImage = UIImage(named: "rsz_heart.png")!
        tabBarItem2.image = heartImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
