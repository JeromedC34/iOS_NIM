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
    @IBOutlet weak var chooseMatch1: UIImageView!
    @IBOutlet weak var chooseMatch2: UIImageView!
    @IBOutlet weak var chooseMatch3: UIImageView!
    @IBAction func sliderChangeNbMatches(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        switch (roundedValue) {
        case 1:
            chooseMatch1.isHidden = false
            chooseMatch2.isHidden = true
            chooseMatch3.isHidden = true
        case 2:
            chooseMatch1.isHidden = false
            chooseMatch2.isHidden = false
            chooseMatch3.isHidden = true
        case 3:
            chooseMatch1.isHidden = false
            chooseMatch2.isHidden = false
            chooseMatch3.isHidden = false
        default:
            chooseMatch1.isHidden = false
            chooseMatch2.isHidden = false
            chooseMatch3.isHidden = false
        }
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

