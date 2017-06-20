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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            (self.view as? SanuView)?.progress = 0.8
            (self.view as? SanuView)?.duration = 2.0
            (self.view as? SanuView)?.animate()
        })
        
    }
}

