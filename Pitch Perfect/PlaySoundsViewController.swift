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
    var currentButton: UIButton!
    var currentButtonImage: UIImage!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioBuffer = AVAudioPCMBuffer()
    var isPlaying: Bool
    let audioPlayer = AVAudioPlayerNode()
    let audioEffect = AVAudioUnitTimePitch()
    let reverbEffect = AVAudioUnitReverb()
    let userDefaults = NSUserDefaults.standardUserDefaults()

    required init?(coder aDecoder: NSCoder) {
        isPlaying = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioBuffer = AVAudioPCMBuffer(PCMFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
        try! audioFile.readIntoBuffer(audioBuffer)
        
        reverbEffect.loadFactoryPreset(.Cathedral)
        
        audioEngine.attachNode(audioPlayer)
        audioEngine.attachNode(audioEffect)
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayer, to: audioEffect, format: audioBuffer.format)
        audioEngine.connect(audioEffect, to: reverbEffect, format: audioBuffer.format)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: audioBuffer.format)
        audioEngine.connect(audioEngine.mainMixerNode, to: audioEngine.outputNode, format: audioBuffer.format)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func playAudio() {
        audioPlayer.volume = 4.0
        audioPlayer.scheduleBuffer(audioBuffer, atTime: nil, options: AVAudioPlayerNodeBufferOptions.Interrupts) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.revertToDefaultButton()
                self.isPlaying = false
            })
        }
        
        audioEngine.prepare()
        try! audioEngine.start()
        isPlaying = true
        audioPlayer.play()
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        resetAudioEffects()
    }
    
    func resetAudioEffects() {
        audioEffect.rate = 1.0;
        audioEffect.pitch = 1.0;
    }
    
    func playWithPitch(pitch: Float) {
        stopAudio()
        audioEffect.pitch = pitch
        playAudio()
    }
    
    func playWithSpeed(rate: Float) {
        stopAudio()
        audioEffect.rate = rate
        playAudio()
    }
    
    func setButtonToStop(btn: UIButton) {
        currentButton = btn
        currentButtonImage = btn.currentImage
        btn.setImage(UIImage(named: "stop"), forState: .Normal)
    }
    
    func revertToDefaultButton() {
        currentButton.setImage(currentButtonImage, forState: .Normal)
        currentButton = nil
    }
    
    func buttonSwapAndAction(btn: UIButton, playAction: () -> Void) {
        if (isPlaying) {
            stopAudio()
        }
        
        if (currentButton == nil || (currentButton != nil && !currentButton.isEqual(btn))) {
            playAction()
            setButtonToStop(btn)
        }
    }
    
    @IBAction func reverbSliderChanged(sender: UISlider) {
        reverbEffect.wetDryMix = sender.value
    }
    
    @IBAction func playInVaderVoice(sender: UIButton) {
        buttonSwapAndAction(sender) {
            let defaultSetting = self.userDefaults.floatForKey("vaderEffectSetting")
            self.playWithPitch(defaultSetting)
        }
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
         buttonSwapAndAction(sender) {
            let defaultSetting = self.userDefaults.floatForKey("chipmunkEffectSetting")
            self.playWithPitch(defaultSetting)
        }
    }
    
    @IBAction func speedUpSound(sender: UIButton) {
         buttonSwapAndAction(sender) {
            let defaultSetting = self.userDefaults.floatForKey("rabbitEffectSetting")
            self.playWithSpeed(defaultSetting)
        }
    }
    
    @IBAction func slowDownSound(sender: UIButton) {
        buttonSwapAndAction(sender) {
            let defaultSetting = self.userDefaults.floatForKey("snailEffectSetting")
            self.playWithSpeed(defaultSetting)
        }
    }

}
