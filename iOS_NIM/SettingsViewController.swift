//
//  SettingsViewController.swift
//  iOS_NIM
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var humanVsHumanSwitch: UISwitch!
    @IBOutlet weak var nbMaxMatches: UISegmentedControl!
    override func viewWillAppear(_ animated: Bool) {
        humanVsHumanSwitch.isOn = NIMGame.getHumanVsHumanSetting()
        if (NIMGame.getMaxNbMatchesSettings() == 10) {
            nbMaxMatches.selectedSegmentIndex = 0
        } else {
            nbMaxMatches.selectedSegmentIndex = 1
        }
    }
    @IBAction func changeHumanVsHuman(_ sender: UISwitch) {
        NIMGame.setHumanVsHumanSetting(value: sender.isOn)
    }
    @IBAction func changeMaxNbMatches(_ sender: UISegmentedControl) {
        let maxNbMatches:Int
        if (sender.selectedSegmentIndex == 0) {
            maxNbMatches = 10
        } else {
            maxNbMatches = 20
        }
        NIMGame.setMaxNbMatchesSettings(value: maxNbMatches)
    }
    @IBAction func closeSettings() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
