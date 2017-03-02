//
//  Meme.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 24..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit

struct Meme{

    // Mark: - MemeMe componentㄴ
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    static let MemedImage = "memedImage"
    
    
    // MARK: init
    
    init(topText: String!, bottomText: String!, originalImage: UIImage!, memedImage: UIImage!){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
