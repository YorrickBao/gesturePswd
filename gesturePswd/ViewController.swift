//
//  ViewController.swift
//  gesturePswd
//
//  Created by 鲍的Mac on 9/30/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model: GesturePswdModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let failureHandler = {
            print("failure")
        }
        
        let successHandler = {
            print("success")
        }
        
        model = GesturePswdModel(tileMargin: 50, superView: view, failureHandler: failureHandler, successHandler: successHandler)
        model.password = "012"
    }


}

