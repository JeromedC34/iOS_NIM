//
//  ScoresTableViewController.swift
//  iOS_NIM
//
//  Created by imac on 18/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import UIKit

class ScoresTableViewController: UITableViewController {
    private var _game:NIMGame?
    public var game:NIMGame? {
        get {
            return _game
        }
        set {
            _game = newValue
        }
    }
    private var _list:[(key:String, value:Int)]?
    @IBAction func resetScores(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Reset scores", message: "Your scores will be lost.\nDo you really want to do it?", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
            action in
            switch action.style{
            default:
                if let currentGame = self._game {
                    currentGame.resetScores()
                    self.getScores()
                }
                self.tableView.reloadData()
            }
        }))
    }
    private func getScores() {
        if let currentGame = _game,
            let scores = currentGame.getScores() {
            _list = scores.sorted(by: { $0.value > $1.value })
        } else {
            _list = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getScores()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = _list {
            return list.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score-cell", for: indexPath)
        if let scoreLine = _list?[indexPath.row] {
            cell.textLabel?.text = scoreLine.key
            cell.detailTextLabel?.text = "Score: \(scoreLine.value)"
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
