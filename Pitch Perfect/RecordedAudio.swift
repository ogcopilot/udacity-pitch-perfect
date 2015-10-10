//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Aaron Wagner on 10/1/15.
//  Copyright © 2015 Aaron Wagner. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    // constructor
    init(title: String, url: NSURL) {
        self.title = title
        self.filePathUrl = url
    }
    
    var filePathUrl: NSURL!
    var title: String!
}