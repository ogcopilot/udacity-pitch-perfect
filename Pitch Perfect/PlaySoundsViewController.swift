//
//  PlaybackViewController.swift
//  Pitch Perfect
//
//  Created by Aaron Wagner on 9/30/15.
//  Copyright © 2015 Aaron Wagner. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        } catch {
            print("error in audio initialization")
        }
        audioPlayer.enableRate = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playWithSpeed(rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }

    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    @IBAction func speedUpSound(sender: AnyObject) {
        self.playWithSpeed(2.0)
    }
    
    @IBAction func slowDownSound(sender: AnyObject) {
        self.playWithSpeed(0.5)
    }

}
