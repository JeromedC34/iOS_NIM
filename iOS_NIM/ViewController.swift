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
        _game.play(nbMatchesSelected: Int(sliderNbMatches.value))
        setDisplay()
    }
    required init?(coder aDecoder: NSCoder) {
        _game = NIMGame()
        super.init(coder: aDecoder)
    }
    private var _game:NIMGame
    private func setDisplay(reset:Bool = false) {
        labelIndicator.text = "\(_game.getCurrentPlayerName()) - Remaining  \(_game.remainingMatches) matches"
        for i:Int in 0..<_game.limitMaxMatches {
            if (i >= _game.remainingMatches) {
                remainingMatches[i].alpha = 0
            } else {
                remainingMatches[i].alpha = 1
            }
        }
        sliderNbMatches.maximumValue = Float(_game.maxInput)
        if (sliderNbMatches.maximumValue > 0) {
            sliderNbMatches.minimumValue = 1
        }
        if (reset) {
            sliderNbMatches.value = Float(_game.maxInput)
        }
        sliderChangeNbMatches(sliderNbMatches)
        if (_game.isGameOver()) {
            gameOver()
        }
    }
    private func gameOver() {
        let alert = UIAlertController(title: "Game over", message: "\((_game.winnerName)!) has won!", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
            action in
            switch action.style{
            default:
                self.restartGame()
            }
        }))
    }
    private func showSettings() {
        let settingsVC:SettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsVC.setGame(game: _game)
        if let navController = self.navigationController {
            navController.pushViewController(settingsVC, animated: true)
        }
    }
    private func restartGame() {
        _game.newGame()
        setDisplay(reset:true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scoresVC = segue.destination as? ScoresViewController {
            scoresVC.game = _game
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showSettingsSegue" {
            if (_game.hasStarted()) {
                let alert = UIAlertController(title: "Change settings", message: "Your game will be restarted if you change any setting.\nDo you really want to do it?", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
                    action in
                    switch action.style{
                    default:
                        self.showSettings()
                    }
                }))
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        restartGame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDisplay()
    }
}
