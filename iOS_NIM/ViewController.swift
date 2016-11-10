//
//  ViewController.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelIndicator: UILabel!
    @IBOutlet weak var nbMatches: UILabel!
    @IBAction func sliderChangeNbMatches(_ sender: UISlider) {
        nbMatches.text = sender.value as String
    }
    @IBAction func btnPlay(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

