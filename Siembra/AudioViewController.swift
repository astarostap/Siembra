//
//  AudioViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var PausePlay: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var storyHeader: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var scrollviewPageWidth = 370
    
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
        let ButtonAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("spaceman", ofType: "mp3")!)
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioUrl)
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        } catch {}
        storyHeader.text = storyHeaderText
        storyHeader.sizeToFit()
        setPagesInScroll()
        self.pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func configPageControl(numPages: Int) {
        self.pageControl.numberOfPages = numPages
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        
    }
    
    func setPagesInScroll() {
        let scrollViewWidth = scrollviewPageWidth
        let scrollViewHeight = 317
        
        let splits = breakStoryUpByCell()
        var x = 0
        for cellText in splits {
            let textView = UITextView(frame: CGRect(x:x,y:0,width:scrollViewWidth, height:scrollViewHeight))
            textView.text = cellText
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
        turnPageRight()
        
    }
    
    func turnPageRight() {
        if (pageControl.currentPage < pageControl.numberOfPages - 1) {
            let curr = scrollView.contentOffset
            let newX = CGPoint(x: curr.x + CGFloat(scrollviewPageWidth), y: 0)
            scrollView.setContentOffset(newX, animated: true)
            pageControl.currentPage += 1
        }
    }
    
    func turnPageLeft() {
        if (pageControl.currentPage > 0) {
            let curr = scrollView.contentOffset
            let newX = CGPoint(x: curr.x - CGFloat(scrollviewPageWidth), y: 0)
            scrollView.setContentOffset(newX, animated: true)
            pageControl.currentPage += 1
        }
    }
    
}

//extension AudioViewController: UICollectionViewDataSource {
//    
//    
//    
//    func breakStoryUpByCell() -> [String] {
//        let numWordsPerCell = 50
//        var result = [String]()
//        let split = fileText!.componentsSeparatedByString(" ")
//        var temp = ""
//        for i in 0...split.count - 1 {
//            let currWord = split[i]
//            temp += " " + currWord
//            if (i != 0 && i % numWordsPerCell  == 0){
//                result.append(temp)
//                temp = ""
//            }
//        }
//        if (temp != "") {
//            result.append(temp)
//        }
//        return result
//    }

//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return breakStoryUpByCell().count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StoryTextCell", forIndexPath: indexPath) as! StoryTextCell
//        cell.storyText.text = breakStoryUpByCell()[indexPath.item]
//        return cell
//    }
//}
