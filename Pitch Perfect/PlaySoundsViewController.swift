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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var player: AVAudioPlayer! = nil
    
    @IBAction func slowDownSound(sender: AnyObject) {
        print("in slowDownSound")
        do {
            
        let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        print(path)
        let url = NSURL.fileURLWithPath(path!)
        print(url.debugDescription)
        try player = AVAudioPlayer.init(contentsOfURL: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print("ERROR")
        }
    }

}
