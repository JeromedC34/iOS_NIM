//
//  NIMGame.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation

class NIMGame {
    private static let _limitMaxMatches:Int = 20
    public static var maxMatches:Int = NIMGame.getMaxNbMatchesSettings()
    public static var maxRemovableMatches:Int = 3
    public static let playerIAName:String = "IA"
    public static let player1NameDefault:String = "Player 1"
    public static let player2NameDefault:String = "Player 2"
    private static let PLAYER_1_NAME_KEY:String = "player1Name"
    private static let PLAYER_2_NAME_KEY:String = "player2Name"
    private static let CHOICE_HUMAN_VS_HUMAN_KEY:String = "choiceHumanVsHuman"
    private static let MAX_NB_MATCHES_KEY:String = "maxNbMatches"
    private static let WHO_PLAYS_FIRST_KEY:String = "whoPlaysFirst"
    private static let SCORES_KEY:String = "scores"
    
    public var remainingMatches:Int = maxMatches
    public var currentPlayer:Int = 1
    public var maxInput:Int {
        get{
            return min(remainingMatches, NIMGame.maxRemovableMatches)
        }
    }
    public var limitMaxMatches:Int {
        return NIMGame._limitMaxMatches
    }
    public var winnerName:String? {
        get{
            if isGameOver() {
                if (currentPlayer == 1) {
                    return NIMGame.getPlayer2Name()
                } else {
                    return NIMGame.getPlayer1Name()
                }
            } else {
                return nil
            }
        }
    }
    func newGame() {
        remainingMatches = NIMGame.getMaxNbMatchesSettings()
        NIMGame.maxMatches = NIMGame.getMaxNbMatchesSettings()
        currentPlayer = NIMGame.getWhoPlaysFirst()
        if (currentPlayer == 3) {
            currentPlayer = generateRandomNumber(min:1, max:2)
        }
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
    static func resetSettings() {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: NIMGame.PLAYER_1_NAME_KEY)
        userDefaults.removeObject(forKey: NIMGame.PLAYER_2_NAME_KEY)
        userDefaults.removeObject(forKey: NIMGame.CHOICE_HUMAN_VS_HUMAN_KEY)
        userDefaults.removeObject(forKey: NIMGame.MAX_NB_MATCHES_KEY)
        userDefaults.removeObject(forKey: NIMGame.WHO_PLAYS_FIRST_KEY)
    }
    func resetScores() {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: NIMGame.SCORES_KEY)
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
	func getScores() -> [String:Int]? {
        let userDefaults:UserDefaults = UserDefaults.standard
        var result:[String:Int]?
        if (userDefaults.dictionary(forKey: NIMGame.SCORES_KEY) as? [String : Int] != nil) {
            result = userDefaults.dictionary(forKey: NIMGame.SCORES_KEY) as? [String : Int]
        }
        return result
	}
	static func setScores(scores:[String:Int]) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(scores, forKey: SCORES_KEY)
	}
	private func saveScore() {
		var scores:[String:Int]? = self.getScores()
		let player1Name:String = NIMGame.getPlayer1Name()
		let player2Name:String = NIMGame.getPlayer2Name()
		let addPlayer1:Int
		let addPlayer2:Int
		if (currentPlayer == 1) {
			addPlayer1 = 0
			addPlayer2 = 10
		} else {
			addPlayer1 = 10
			addPlayer2 = 0
		}
		if (scores != nil) {
			if (scores![player1Name] != nil) {
				scores![player1Name] = scores![player1Name]! + addPlayer1
			} else {
                scores![player1Name] = addPlayer1
			}
			if (scores![player2Name] != nil) {
				scores![player2Name] = scores![player2Name]! + addPlayer2
			} else {
				scores![player2Name] = addPlayer2
			}
        } else {
            scores = [player1Name:addPlayer1]
            scores![player2Name] = addPlayer2
        }
		NIMGame.setScores(scores: scores!)
	}
    private func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max - min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    static func setPlayer1Name(value:String) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: PLAYER_1_NAME_KEY)
    }
	static func getPlayer1Name() -> String {
        let userDefaults:UserDefaults = UserDefaults.standard
        var playerName:String
        // Sets the default value if not already set
        if (userDefaults.string(forKey: PLAYER_1_NAME_KEY) == nil) {
            playerName = player1NameDefault
        } else {
            playerName = userDefaults.string(forKey: PLAYER_1_NAME_KEY)!
        }
		return playerName
	}
    static func setPlayer2Name(value:String) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: PLAYER_2_NAME_KEY)
    }
    static func getPlayer2Name() -> String {
        let userDefaults:UserDefaults = UserDefaults.standard
        var playerName:String
        if (NIMGame.getHumanVsHumanSetting()) {
            // Sets the default value if not already set
            if (userDefaults.string(forKey: PLAYER_2_NAME_KEY) == nil || userDefaults.string(forKey: PLAYER_2_NAME_KEY) == playerIAName) {
                playerName = player2NameDefault
            } else {
                playerName = userDefaults.string(forKey: PLAYER_2_NAME_KEY)!
            }
        } else {
            playerName = playerIAName
        }
        return playerName
    }
    func getCurrentPlayerName() -> String {
        var playerName:String
        if (currentPlayer == 1) {
            playerName = NIMGame.getPlayer1Name()
        } else {
            playerName = NIMGame.getPlayer2Name()
        }
        return playerName
    }
    static func setHumanVsHumanSetting(value:Bool) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: CHOICE_HUMAN_VS_HUMAN_KEY)
    }
    static func getHumanVsHumanSetting() -> Bool {
        let userDefaults:UserDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: CHOICE_HUMAN_VS_HUMAN_KEY) == nil) {
            return true
        } else {
            return userDefaults.bool(forKey: CHOICE_HUMAN_VS_HUMAN_KEY)
        }
    }
    static func setMaxNbMatchesSettings(value:Int) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: MAX_NB_MATCHES_KEY)
    }
    static func getMaxNbMatchesSettings() -> Int {
        let userDefaults:UserDefaults = UserDefaults.standard
        var maxNbMatches:Int = userDefaults.integer(forKey: MAX_NB_MATCHES_KEY)
		// Sets the default value if not already set
        if (maxNbMatches == 0) {
            maxNbMatches = 20
		}
        return maxNbMatches
    }
    static func setWhoPlaysFirst(value:Int) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: WHO_PLAYS_FIRST_KEY)
    }
    static func getWhoPlaysFirst() -> Int {
        let userDefaults:UserDefaults = UserDefaults.standard
        var whoPlaysFirst:Int = userDefaults.integer(forKey: WHO_PLAYS_FIRST_KEY)
        // Sets the default value if not already set
        if (whoPlaysFirst == 0) {
            whoPlaysFirst = 1
        }
        return whoPlaysFirst
    }
}
