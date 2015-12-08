//
//  AudioViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var PausePlay: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var storyHeader: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var viewOverProgressBar: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    var currOffset = 0
    var currPage = 0
    
    var scrollviewPageWidth = 359
    
    var pageControlBeingUsed: Bool = false
    
    func breakStoryUpByCell() -> [String] {
        let numWordsPerCell = 50
        var result = [String]()
        let split = fileText!.componentsSeparatedByString(" ")
        var temp = ""
        for i in 0...split.count - 1 {
            let currWord = split[i]
            temp += " " + currWord
            if (i != 0 && i % numWordsPerCell  == 0){
                result.append(temp)
                temp = ""
            }
        }
        if (temp != "") {
            result.append(temp)
        }
        return result
    }
    
    var storyHeaderText = ""
    var fileText: String?
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlBeingUsed = false
        let ButtonAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("return_to_paradise", ofType: "mp3")!)
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioUrl)
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        } catch {}
        storyHeader.text = storyHeaderText
        storyHeader.sizeToFit()
        setPagesInScroll()
        scrollView.delegate = self
        scrollView.layer.cornerRadius = CGFloat(10)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapAudioProgress:"))

        viewOverProgressBar.addGestureRecognizer(tapGesture)
    }
    
    func tapAudioProgress(tapGesture: UITapGestureRecognizer) {
        let tappedPoint = tapGesture.locationInView(viewOverProgressBar)
        let x = tappedPoint.x
        let percentage = x / progressView.frame.width
        progressView.progress = Float(percentage)
        print("tapped: " + String(x) + " percentage: " + String(percentage))
        
        let numSecsTotal = NSNumber(double: ButtonAudioPlayer.duration) as Double
        let numSecsAtTapped = numSecsTotal * Double(percentage)
        
        
        let currentTime = NSTimeInterval(numSecsAtTapped)
        ButtonAudioPlayer.currentTime = currentTime
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > CGFloat(currOffset) ) {
            currPage += 1
        } else {
            currPage -= 1
        }
        currOffset = Int(scrollView.contentOffset.x)
        pageControl.currentPage = currPage
    }
    
    deinit {
        if let superView = self.view.superview
        {
            superView.removeFromSuperview()
        }
    }
    
    func configPageControl(numPages: Int) {
        self.pageControl.numberOfPages = numPages
        self.pageControl.currentPage = currPage
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
    }
    
    func formatAttributedText(text: String) -> NSAttributedString {
        let defaults = NSUserDefaults.standardUserDefaults()
        var fontSize = 20
        if let value = defaults.objectForKey("fontSize") as? Int {
            fontSize = value
        }
        
        
        let storyFont:UIFont = UIFont(name: "Arial", size: CGFloat(fontSize))!
        let attributes = [
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName: storyFont
        ]
        return NSAttributedString(string: text, attributes: attributes)    }
    
    func setPagesInScroll() {
        let scrollViewWidth = scrollviewPageWidth
        let scrollViewHeight = 317
        
        let splits = breakStoryUpByCell()
        var x = 0
        for cellText in splits {
            let textView = UITextView(frame: CGRect(x:x,y:0,width:scrollViewWidth, height:scrollViewHeight))
            let strAttr = formatAttributedText(cellText)
            textView.attributedText = strAttr

            scrollView.addSubview(textView)
            x += scrollViewWidth
        }
        self.scrollView.contentSize = CGSizeMake(CGFloat(scrollViewWidth * splits.count),  CGFloat(scrollViewHeight))
        configPageControl(splits.count)
    }
    
    func updateProgressView() {
        let currTime = ButtonAudioPlayer.currentTime
        let totalTime = ButtonAudioPlayer.duration
        
        let percentage = currTime / totalTime
        progressView.progress = Float(percentage)
        
        let total = Int(totalTime)
        let totalSeconds = total % 60
        let totalMinutes = (total / 60) % 60
        
        let curr = Int(currTime)
        let currSeconds = curr % 60
        let currMinutes = (curr / 60) % 60

        let currText = String(format: "%2d:%02d", currMinutes, currSeconds)
        let totalText = String(format: "%2d:%02d", totalMinutes, totalSeconds)
        timeLabel.text = currText + "/" + totalText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func PausePlay(sender: UIButton) {
        if (ButtonAudioPlayer.playing == true) {
            ButtonAudioPlayer.stop()
            PausePlay.setTitle("Play", forState: UIControlState.Normal)
            PausePlay.setImage(UIImage(named: "rsz_1play_button.png"), forState: .Normal)
        } else {
            ButtonAudioPlayer.play()
            PausePlay.setTitle("Pause", forState: UIControlState.Normal)
            PausePlay.setImage(UIImage(named: "rsz_pause.png"), forState: .Normal)
        }
        
    }
    
    func turnPageRight() {
        if (pageControl.currentPage < pageControl.numberOfPages - 1) {
            let curr = scrollView.contentOffset
            let newX = CGPoint(x: curr.x + CGFloat(scrollviewPageWidth), y: 0)
            scrollView.setContentOffset(newX, animated: true)
            pageControl.currentPage += 1
            currPage += 1
        }
    }
    
    func turnPageLeft() {
        if (pageControl.currentPage > 0) {
            let curr = scrollView.contentOffset
            let newX = CGPoint(x: curr.x - CGFloat(scrollviewPageWidth), y: 0)
            scrollView.setContentOffset(newX, animated: true)
            pageControl.currentPage += 1
            currPage -= 1
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        turnPageRight()
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc: UIViewController? = segue.destinationViewController
        if let contributionController = destinationvc as? StoryContributionViewController {
            contributionController.storyName = storyHeader.text
        }
    }
}

