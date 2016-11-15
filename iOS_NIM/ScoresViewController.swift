//
//  ScoresViewController.swift
//  iOS_NIM
//
//  Created by imac on 15/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var scoresTextView: UITextView!
    @IBAction func closeScores() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetScores() {
        NIMGame.resetScores()
        setDisplay()
    }
    private func setDisplay() {
        let scores:[String:Int]? = NIMGame.getScores()
        if (scores != nil) {
            scoresTextView.text = ""
            for (key, value) in scores! {
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
