//
//  BaseViewController.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func alert(message: String, title: String = "") {
        
        self.view.makeToast(message.localized(), duration: 3.0, position: CSToastPositionCenter)
    }
}
