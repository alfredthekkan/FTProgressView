//
//  ViewController.swift
//  FTProgressView
//
//  Created by alfredthekkan on 06/19/2017.
//  Copyright (c) 2017 alfredthekkan. All rights reserved.
//

import UIKit
import FTProgressView

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (view as? SanuView)?.progress = 0.6
        (view as? SanuView)?.animate()
    }
}

