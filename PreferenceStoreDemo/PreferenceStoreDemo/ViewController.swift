//
//  ViewController.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/11/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(_ animated: Bool) {
        let demoViewController = DemoViewController()
        self.present(demoViewController, animated: true, completion: nil)
    }
}

