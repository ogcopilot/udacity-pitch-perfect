//
//  PlaybackViewController.swift
//  Pitch Perfect
//
//  Created by Aaron Wagner on 9/30/15.
//  Copyright © 2015 Aaron Wagner. All rights reserved.
//

import UIKit

class PlaybackViewController: UIViewController {
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

}
