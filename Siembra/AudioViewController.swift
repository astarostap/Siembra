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
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var StoryText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ButtonAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("spaceman", ofType: "mp3")!)
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioUrl)
            print("hey there babe")
            print("hey quentin")
            print("hello")
        } catch {
            
        }
        
        do {
            let text = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("sample", ofType: "txt")!, encoding: NSUTF8StringEncoding)
            StoryText.text = text as String
        } catch {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PlayAudio1(sender: UIButton) {
        ButtonAudioPlayer.play()
    }
    
    @IBAction func Stop(sender: UIButton) {
        ButtonAudioPlayer.stop()
        ButtonAudioPlayer.currentTime = 0
    }
    
    @IBAction func Restart(sender: UIButton) {
        ButtonAudioPlayer.stop()
        ButtonAudioPlayer.currentTime = 0
        ButtonAudioPlayer.play()
        PausePlay.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    @IBAction func PausePlay(sender: UIButton) {
        if (ButtonAudioPlayer.playing == true) {
            ButtonAudioPlayer.stop()
            PausePlay.setTitle("Play", forState: UIControlState.Normal)
        } else {
            ButtonAudioPlayer.play()
            PausePlay.setTitle("Pause", forState: UIControlState.Normal)
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
