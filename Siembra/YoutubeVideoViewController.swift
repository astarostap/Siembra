//
//  YoutubeVideoViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class YoutubeVideoViewController: UIViewController {

    @IBOutlet weak var videoView: UIWebView!
    
    var videoEmbedHtml: String?
    var videoUrl: String? {
        didSet {
            print("video url: " + videoUrl!)
            
            let embedHtml = "<iframe width=\"560\" height=\"315\" src=\"\(videoUrl!)\" frameborder=\"0\" allowfullscreen></iframe>"
            
            print("embed html: " + embedHtml)
            videoEmbedHtml = embedHtml
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        print(videoEmbedHtml)
        videoView.loadHTMLString(videoEmbedHtml!, baseURL: nil)
    }
    
}
