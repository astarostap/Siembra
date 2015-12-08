//
//  AudioRecordingViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/5/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import AVKit
import UIKit
import AVFoundation

//INSPIRED BY https://www.youtube.com/watch?v=4qj1piMAPE0
class AudioRecordingViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeRecorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer = AVAudioPlayer()
    
    //initializes sound recorder. it lets the user record audio and play it.
    func intializeRecorder() {
        let settings: [String : AnyObject] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:320000,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
        ]
        
        try! soundRecorder = AVAudioRecorder(URL: fileUrl(), settings: settings)
        
        soundRecorder.delegate = self
        soundRecorder.prepareToRecord()
    }
    
    //gets the file url where the sound recording will be saved
    private func fileUrl() -> NSURL {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        
        let newFileName = "newRecording.m4a"
        let path = paths[0].stringByAppendingPathComponent(newFileName)
        let url = NSURL(fileURLWithPath: path)
        return url
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        
        if (statusLabel.text != "Recording") {
            soundRecorder.record()
            playBtn.enabled = false
            statusLabel.text = "Recording"
        } else {
            soundRecorder.stop()
            statusLabel.text = "Not Recording"
            playBtn.enabled = true
        }
        
    }
    
    
    var isPlaying: Bool = false

    @IBAction func playTapped(sender: UIButton) {
        if (!isPlaying) {
            recordBtn.enabled = false
            try! soundPlayer = AVAudioPlayer(contentsOfURL: fileUrl())
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer,
        successfully flag: Bool) {
            recordBtn.enabled = true
    }
}

extension String {
    func stringByAppendingPathComponent(pathComponent: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(pathComponent)
    }
}
