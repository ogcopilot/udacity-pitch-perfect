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
    
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    let audioEffect = AVAudioUnitTimePitch()
    let audioPlayer = AVAudioPlayerNode()
    let reverbEffect = AVAudioUnitReverb()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioEngine.attachNode(audioPlayer)
        audioEngine.attachNode(audioEffect)
        audioEngine.connect(audioPlayer, to: audioEffect, format: nil)
        audioEngine.connect(audioEffect, to: audioEngine.mainMixerNode, format: nil)
        audioEngine.connect(audioEngine.mainMixerNode, to: audioEngine.outputNode, format: nil)
        audioEngine.attachNode(reverbEffect)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: nil)

        var effectDefaults = Dictionary<String, AnyObject>()
        effectDefaults["vaderEffectSetting"] = -1000
        effectDefaults["chipmunkEffectSetting"] = 2000
        effectDefaults["rabbitEffectSetting"] = 2.0
        effectDefaults["snailEffectSetting"] = 0.5
        userDefaults.registerDefaults(effectDefaults)
        userDefaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio() {
        audioPlayer.volume = 2.0
        audioPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayer.play()
        // I can't tell if the reverb effect is doing anything or not... :(
        print("reverb set to \(reverbEffect.wetDryMix)")
    }
    
    func resetAudioEffects() {
        audioEffect.rate = 1.0;
        audioEffect.pitch = 1.0;
    }
    
    func playWithPitch(pitch: Float) {
        stopPlayback(self)
        audioEffect.pitch = pitch
        playAudio()
    }
    
    func playWithSpeed(rate: Float) {
        stopPlayback(self)
        audioEffect.rate = rate
        playAudio()
    }
    
    @IBAction func reverbSliderChanged(sender: UISlider) {
        reverbEffect.wetDryMix = sender.value
    }
    
    @IBAction func playInVaderVoice(sender: AnyObject) {
        let defaultSetting = userDefaults.floatForKey("vaderEffectSetting")
        self.playWithPitch(defaultSetting)
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        let defaultSetting = userDefaults.floatForKey("chipmunkEffectSetting")
        self.playWithPitch(defaultSetting)
    }
    
    @IBAction func speedUpSound(sender: AnyObject) {
        let defaultSetting = userDefaults.floatForKey("rabbitEffectSetting")
        self.playWithSpeed(defaultSetting)
    }
    
    @IBAction func slowDownSound(sender: AnyObject) {
        let defaultSetting = userDefaults.floatForKey("snailEffectSetting")
        self.playWithSpeed(defaultSetting)
    }
    
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        resetAudioEffects()
    }

}
