//
//  AudioViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/16/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    @IBOutlet weak var PausePlay: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textView: UITextView!
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ButtonAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("spaceman", ofType: "mp3")!)
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioUrl)
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        } catch {
            
        }
        
        do {
            let text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("sample_story", ofType: "txt")!, encoding: NSUTF8StringEncoding)
            let attributedString:NSAttributedString = NSAttributedString(string: text as String)
            textView.attributedText = attributedString
        } catch {
            
        }
        
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
    

//    @IBAction func PlayAudio1(sender: UIButton) {
//        ButtonAudioPlayer.play()
//    }
//    
//    @IBAction func Stop(sender: UIButton) {
//        ButtonAudioPlayer.stop()
//        ButtonAudioPlayer.currentTime = 0
//    }
//    
//    @IBAction func Restart(sender: UIButton) {
//        ButtonAudioPlayer.stop()
//        ButtonAudioPlayer.currentTime = 0
//        ButtonAudioPlayer.play()
//        PausePlay.setTitle("Pause", forState: UIControlState.Normal)
//    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
