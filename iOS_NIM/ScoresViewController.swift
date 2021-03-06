//
//  ScoresViewController.swift
//  iOS_NIM
//
//  Created by imac on 15/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {
    private var _game:NIMGame?
    public var game:NIMGame? {
        get {
            return _game
        }
        set {
            _game = newValue
        }
    }
    @IBOutlet weak var scoresTextView: UITextView!
    @IBAction func closeScores() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetScores() {
        let alert = UIAlertController(title: "Reset scores", message: "Your scores will be lost.\nDo you really want to do it?", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
            action in
            switch action.style{
            default:
                if let currentGame = self._game {
                    currentGame.resetScores()
                }
                self.setDisplay()
            }
        }))
    }
    private func setDisplay() {
        if let currentGame = _game,
            let scores = currentGame.getScores() {
            scoresTextView.text = ""
            let scoresSorted = scores.sorted(by: { $0.value > $1.value })
            for (key, value) in scoresSorted {
                scoresTextView.text = scoresTextView.text! + "\(key): \(value)\n"
            }
        } else {
            scoresTextView.text = "No score yet..."
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
