//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 25..
//  Copyright © 2017년 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController{

    // Mark: Properties
    var meme: Meme!
    
    // Mark: Outlets
    @IBOutlet weak var memedImage: UIImageView!
    
    
    // Mark: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImage.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
