//
//  SettingsViewController.swift
//  iOS_NIM
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    private var hasChangedSettings:Bool = false
    private var _game:NIMGame? = nil
    @IBOutlet weak var humanVsHumanSwitch: UISwitch!
    @IBOutlet weak var nbMaxMatches: UISegmentedControl!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var whoPlaysFirst: UISegmentedControl!
    @IBAction func resetSettings() {
        let alert = UIAlertController(title: "Reset settings", message: "Your settings will be lost.\nDo you really want to do it?", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
            action in
            switch action.style{
            default:
                self.hasChangedSettings = true
                NIMGame.resetSettings()
                self.setDisplay()
            }
        }))
    }
    override func viewWillAppear(_ animated: Bool) {
        setDisplay()
    }
    @IBAction func changeHumanVsHuman(_ sender: UISwitch) {
        hasChangedSettings = true
        NIMGame.setHumanVsHumanSetting(value: sender.isOn)
        checkIA()
    }
    func setGame(game:NIMGame) {
        self._game = game
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
        hasChangedSettings = true
        let maxNbMatches:Int
        if (sender.selectedSegmentIndex == 0) {
            maxNbMatches = 10
        } else {
            maxNbMatches = 20
        }
        NIMGame.setMaxNbMatchesSettings(value: maxNbMatches)
    }
    @IBAction func changeWhoPlaysFirst(_ sender: UISegmentedControl) {
        hasChangedSettings = true
        let whoPlaysFirst:Int
        whoPlaysFirst = sender.selectedSegmentIndex + 1
        NIMGame.setWhoPlaysFirst(value: whoPlaysFirst)
    }
    override func viewWillDisappear(_ animated: Bool) {
        if hasChangedSettings,
            let myRunningGame = self._game {
            myRunningGame.newGame()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        player1TextField.delegate = self
        player2TextField.delegate = self
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch (textField.tag) {
        case 1:
            hasChangedSettings = true
            textField.text = NIMGame.setPlayer1Name(value: textField.text!)
        case 2:
            hasChangedSettings = true
            textField.text = NIMGame.setPlayer2Name(value: textField.text!)
        default: break
            // RAS
        }
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
