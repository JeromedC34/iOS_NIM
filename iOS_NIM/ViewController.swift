//
//  ViewController.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var myNIMGame:NIMGame?
    @IBOutlet weak var labelIndicator: UILabel!
    @IBOutlet weak var chooseMatch1: UIImageView!
    @IBOutlet weak var chooseMatch2: UIImageView!
    @IBOutlet weak var chooseMatch3: UIImageView!
    @IBOutlet var remainingMatches: [UIImageView]!
    @IBOutlet weak var sliderNbMatches: UISlider!
    @IBOutlet weak var choiceHumanVsHuman: UISwitch!
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
            chooseMatch1.isHidden = true
            chooseMatch2.isHidden = true
            chooseMatch3.isHidden = true
        }
    }
    @IBAction func btnPlay(_ sender: UIButton) {
        myNIMGame?.play(nbMatchesSelected: Int(sliderNbMatches.value))
        setDisplay()
    }
    required init?(coder aDecoder: NSCoder) {
        myNIMGame = NIMGame()
        super.init(coder: aDecoder)
    }
    private func setDisplay(reset:Bool = false) {
        labelIndicator.text = "Player \((myNIMGame?.currentPlayer)!) - Remaining \((myNIMGame?.remainingMatches)!) matches"
        for i:Int in 0..<NIMGame.limitMaxMatches {
            if (i >= (myNIMGame?.remainingMatches)!) {
                remainingMatches[i].alpha = 0
            } else {
                remainingMatches[i].alpha = 1
            }
        }
        sliderNbMatches.maximumValue = Float((myNIMGame?.maxInput)!)
        if (sliderNbMatches.maximumValue > 0) {
            sliderNbMatches.minimumValue = 1
        }
        if (reset) {
            sliderNbMatches.value = Float((myNIMGame?.maxInput)!)
        }
        sliderChangeNbMatches(sliderNbMatches)
        if (myNIMGame?.isGameOver())! {
            gameOver()
        }
    }
    private func gameOver() {
        let alert = UIAlertController(title: "Game over", message: "Player \((myNIMGame?.currentPlayer)!) has lost!", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
            action in
            switch action.style{
            default:
                self.restartGame()
            }
        }))
    }
    @IBAction func displaySettings() {
        if (myNIMGame?.hasStarted())! {
            let alert = UIAlertController(title: "Change settings", message: "Your game will be restarted.\nDo you really want to do it?", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
                action in
                switch action.style{
                default:
                    self.showSettings()
                }
            }))
        } else {
            showSettings()
        }

    }
    private func showSettings() {
        let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")
        if (settingsVC != nil) {
            present(settingsVC!, animated: true, completion: nil)
        }
    }
    private func isHumanVsHuman() -> Bool {
        let userDefaults:UserDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "choiceHumanVsHuman")
    }
    private func restartGame() {
        myNIMGame?.newGame()
        setDisplay(reset:true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restartGame()
    }
}

