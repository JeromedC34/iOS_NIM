//
//  NIMGame.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation

class NIMGame {
    public static let limitMaxMatches:Int = 20
    public static var maxMatches:Int = NIMGame.getMaxNbMatchesSettings()
    public static var maxRemovableMatches:Int = 3
    
    public var remainingMatches:Int = maxMatches
    public var currentPlayer:Int = 1
    public var maxInput:Int {
        get{
            return min(remainingMatches, NIMGame.maxRemovableMatches)
        }
    }
    func newGame() {
        remainingMatches = NIMGame.getMaxNbMatchesSettings()
        currentPlayer = generateRandomNumber(min:1, max:2)
    }
    func play(nbMatchesSelected:Int) {
        if (currentPlayer == 2 && !NIMGame.getHumanVsHumanSetting()) {
            playIA()
        } else {
            removeMatches(nbMatches: nbMatchesSelected)
        }
    }
    func isGameOver() -> Bool {
        return remainingMatches <= 0
    }
    func hasStarted() -> Bool {
        return remainingMatches != NIMGame.maxMatches
    }
    private func playIA() {
        let nbMatchesSelected:Int
        if (remainingMatches % (NIMGame.maxRemovableMatches + 1) != 1) {
            nbMatchesSelected = ((remainingMatches - 1) % (NIMGame.maxRemovableMatches + 1))
        } else {
            nbMatchesSelected = generateRandomNumber(min:1, max:maxInput)
        }
        removeMatches(nbMatches: nbMatchesSelected)
    }
    private func removeMatches(nbMatches:Int) {
        remainingMatches = remainingMatches - nbMatches
        if (remainingMatches > 0) {
            if (currentPlayer == 1) {
                currentPlayer = 2
            } else {
                currentPlayer = 1
            }
        } else {
			saveScore()
		}
    }
	static func getScores() {
        let userDefaults:UserDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "scores")
	}
	static func setScores(scores:[String: Int]) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(scores, forKey: "scores")
	}
	private func saveScore() {
		var scores:[String: Int] = getScores()
		let player1Name:String = getPlayer1Name()
		let player2Name:String = getPlayer2Name()
		let addPlayer1:Int
		let addPlayer2:Int
		if (currentPlayer == 1) {
			addPlayer1 = 0
			addPlayer1 = 10
		} else {
			addPlayer1 = 10
			addPlayer2 = 0
		}
		if (scores != nil) {
			if (scores[player1Name] != nil) {
				scores[player1Name] += addPlayer1
			} else {
				scores[player1Name] = addPlayer1
			}
			if (scores[player2Name] != nil) {
				scores[player2Name] += addPlayer2
			} else {
				scores[player2Name] = addPlayer2
			}
		}
		setScores(scores)
	}
    private func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max - min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    static func setPlayer1Name(value:String) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: "player1Name")
    }
	static func getPlayer1Name() {
        let userDefaults:UserDefaults = UserDefaults.standard
        var playerName:Int = userDefaults.integer(forKey: "player1Name")
		// Sets the default value if not already set
        if (playerName == "") {
            playerName = "Joueur 1"
		}
		return playerName
	}
    static func setPlayer2Name(value:String) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: "player2Name")
    }
	static func getPlayer2Name() {
        let userDefaults:UserDefaults = UserDefaults.standard
        var playerName:Int = userDefaults.integer(forKey: "player2Name")
		// Sets the default value if not already set
        if (playerName == "") {
            playerName = "Joueur 2"
		}
		return playerName
	}
    static func setHumanVsHumanSetting(value:Bool) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: "choiceHumanVsHuman")
    }
    static func getHumanVsHumanSetting() -> Bool {
        let userDefaults:UserDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "choiceHumanVsHuman")
    }
    static func setMaxNbMatchesSettings(value:Int) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: "maxNbMatches")
    }
    static func getMaxNbMatchesSettings() -> Int {
        let userDefaults:UserDefaults = UserDefaults.standard
        var maxNbMatches:Int = userDefaults.integer(forKey: "maxNbMatches")
		// Sets the default value if not already set
        if (maxNbMatches == 0) {
            maxNbMatches = 20
		}
        return maxNbMatches
    }
}
