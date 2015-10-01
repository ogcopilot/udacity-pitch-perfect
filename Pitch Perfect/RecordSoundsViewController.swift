//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Aaron Wagner on 9/27/15.
//  Copyright © 2015 Aaron Wagner. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var mainAction: UIButton!
    
    var counter: Int = 0
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchToView(viewIdentifier: String) {
        let playbackViewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier(viewIdentifier)
        self.navigationController?.pushViewController(playbackViewControllerObject!, animated: true)
    }
    
    static var recordedAudioPath = NSURL.fileURLWithPathComponents([NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String, "my_audio.wav"])
    
    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: RecordSoundsViewController.recordedAudioPath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func stopRecording() {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        if (counter % 2 == 1) {
            stopRecording()
            switchToView("playback")
        } else {
            startRecording()
        }
        
        mainAction.setImage(UIImage(named: (counter % 2 == 0) ? "stop": "microphone"), forState: .Normal)
        recordingLabel.hidden = !recordingLabel.hidden
        counter++
        print("pressed the button \(counter) times")
    }
}

