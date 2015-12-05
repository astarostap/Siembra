//
//  YoutubeVideoViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import WebKit

class YoutubeVideoViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var videoView: UIWebView!
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var videoUrl: String?
    
    var videoTitleString: String?
    @IBOutlet weak var videoTitle: UILabel? {
        didSet {
            if let text = videoTitleString {
                videoTitle?.text = text
            }
        }
    }
    
    @IBAction func visitInSafari(sender: UIButton) {
        var url : NSURL
        url = NSURL(string: videoUrl!)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    override func viewDidLoad() {
        videoView.delegate = self
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let embedHtml = "<iframe width=\"\(videoView.frame.width)\" height=\"\(videoView.frame.height)\" src=\"\(videoUrl!)/playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        videoView.loadHTMLString(embedHtml, baseURL: nil)
        videoView.allowsInlineMediaPlayback = true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        webView.scrollView.contentOffset = CGPointMake(8, 8)
    }
}
