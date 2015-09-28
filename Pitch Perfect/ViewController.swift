//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Aaron Wagner on 9/27/15.
//  Copyright © 2015 Aaron Wagner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var mainAction: UIButton!
    
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        if counter % 2 == 0 {
            mainAction.setImage(UIImage(named: "stop"), forState: .Normal)
            recordingLabel.hidden = false
        }
        else if counter % 2 == 1 {
            mainAction.setImage(UIImage(named: "microphone"), forState: .Normal)
            recordingLabel.hidden = true
            
        }
        counter++
        // TODO: record the users voice
        print("in recordAudio")
    }


}

