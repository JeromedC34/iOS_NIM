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
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var whoPlaysFirst: UISegmentedControl!
    @IBAction func clearSettings() {
        NIMGame.resetSettings()
        setDisplay()
    }
    override func viewWillAppear(_ animated: Bool) {
        setDisplay()
    }
    @IBAction func changeHumanVsHuman(_ sender: UISwitch) {
        NIMGame.setHumanVsHumanSetting(value: sender.isOn)
        checkIA()
    }
    private func setDisplay() {
        humanVsHumanSwitch.isOn = NIMGame.getHumanVsHumanSetting()
        if (NIMGame.getMaxNbMatchesSettings() == 10) {
            nbMaxMatches.selectedSegmentIndex = 0
        } else {
            nbMaxMatches.selectedSegmentIndex = 1
        }
        player1TextField.text = NIMGame.getPlayer1Name()
        player2TextField.text = NIMGame.getPlayer2Name()
        whoPlaysFirst.selectedSegmentIndex = NIMGame.getWhoPlaysFirst() - 1
        checkIA()
    }
    private func checkIA() {
        if (NIMGame.getHumanVsHumanSetting()) {
            player2TextField.isEnabled = true
            player2TextField.text = NIMGame.getPlayer2Name()
        } else {
            player2TextField.isEnabled = false
            player2TextField.text = NIMGame.getPlayer2Name()
        }
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
    @IBAction func changePlayer1Name(_ sender: UITextField) {
        NIMGame.setPlayer1Name(value: sender.text!)
    }
    @IBAction func changePlayer2Name(_ sender: UITextField) {
        NIMGame.setPlayer2Name(value: sender.text!)
    }
    @IBAction func changeWhoPlaysFirst(_ sender: UISegmentedControl) {
        let whoPlaysFirst:Int
        whoPlaysFirst = sender.selectedSegmentIndex + 1
        NIMGame.setWhoPlaysFirst(value: whoPlaysFirst)
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
