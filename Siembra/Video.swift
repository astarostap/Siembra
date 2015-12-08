//
//  Video.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

//hard coded videos
class Video {
    var title = ""
    var videoUrl = ""
    var featuredImage: UIImage!
    
    
    init(title: String, url: String, image: UIImage) {
        self.title = title
        self.videoUrl = url
        self.featuredImage = image
    }
    
    static func createVideos() -> [Video] {
        return [
            Video(title: "Bored with sex?", url: "https://www.youtube.com/embed/Br0fqr1jQKY", image: UIImage(named: "masturbation.jpg")!),
            Video(title: "Vagina  Hacks", url: "https://www.youtube.com/embed/H7VAHWdr8Ww", image: UIImage(named: "laci2.jpg")!),
            Video(title: "Losing Your VIRGINITY?! ", url: "https://www.youtube.com/embed/kdYtYveJI1Y", image: UIImage(named: "laci3.jpg")!),
            Video(title: "TALK CONDOMS TO ME BBY", url: "https://www.youtube.com/embed/pdCRE2gP66U", image: UIImage(named: "laci4.jpg")!),
            Video(title: "WANNA HAVE SEX? (CONSENT 101)", url: "https://www.youtube.com/embed/TD2EooMhqRI", image: UIImage(named: "laci5.jpg")!),
            Video(title: "THE NAKED LIFE! - NUDISM ", url: "https://www.youtube.com/embed/wh4nUlslmso", image: UIImage(named: "laci6.jpg")!)
        ]
    }
}
