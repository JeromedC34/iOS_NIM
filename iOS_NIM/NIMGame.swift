//
//  NIMGame.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation

class NIMGame {
    private static let LIMIT_MAX_MATCHES:Int = 20
    private static let MAX_REMOVABLE_MATCHES:Int = 3
    private static let PLAYER_IA_NAME:String = "IA"
    private static let PLAYER_1_NAME_DEFAULT:String = "Player 1"
    private static let PLAYER_2_NAME_DEFAULT:String = "Player 2"
    private static let PLAYER_1_NAME_KEY:String = "player1Name"
    private static let PLAYER_2_NAME_KEY:String = "player2Name"
    private static let CHOICE_HUMAN_VS_HUMAN_KEY:String = "choiceHumanVsHuman"
    private static let MAX_NB_MATCHES_KEY:String = "maxNbMatches"
    private static let WHO_PLAYS_FIRST_KEY:String = "whoPlaysFirst"
    private static let SCORES_KEY:String = "scores"

    private var _maxMatches:Int = 0
    private var _remainingMatches:Int = 0
    private var _currentPlayer:Int = 1
    private var _userDefaults:UserDefaults

    public var remainingMatches:Int {
        return _remainingMatches
    }
    public var maxInput:Int {
        get{
            return min(remainingMatches, NIMGame.MAX_REMOVABLE_MATCHES)
        }
    }
    public var limitMaxMatches:Int {
        return NIMGame.LIMIT_MAX_MATCHES
    }
    public var winnerName:String? {
        get{
            if isGameOver() {
                if (_currentPlayer == 1) {
                    return getPlayer2Name()
                } else {
                    return getPlayer1Name()
                }
            } else {
                return nil
            }
        }
    }

    init() {
        _userDefaults = UserDefaults.standard
        _maxMatches = getMaxNbMatchesSettings()
        _remainingMatches = getMaxNbMatchesSettings()
    }
    private func playIA() {
        let nbMatchesSelected:Int
        if (remainingMatches % (NIMGame.MAX_REMOVABLE_MATCHES + 1) != 1) {
            nbMatchesSelected = ((remainingMatches - 1) % (NIMGame.MAX_REMOVABLE_MATCHES + 1))
        } else {
            nbMatchesSelected = generateRandomNumber(min:1, max:maxInput)
        }
        removeMatches(nbMatches: nbMatchesSelected)
    }
    private func removeMatches(nbMatches:Int) {
        _remainingMatches = remainingMatches - nbMatches
        if (remainingMatches > 0) {
            if (_currentPlayer == 1) {
                _currentPlayer = 2
            } else {
                _currentPlayer = 1
            }
        } else {
            saveScore()
        }
    }
    private func saveScore() {
        var scores:[String:Int]? = self.getScores()
        let player1Name:String = getPlayer1Name()
        let player2Name:String = getPlayer2Name()
        let addPlayer1:Int
        let addPlayer2:Int
        if (_currentPlayer == 1) {
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
        setScores(scores: scores!)
    }
    private func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max - min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    private func filterPlayerName(value:String) -> String {
        return value.replacingOccurrences(of: " ", with: "_")
    }
    private func filterPlayer1Name(value:String) -> String {
        var result = filterPlayerName(value: value)
        if (result == "") {
            result = NIMGame.PLAYER_1_NAME_DEFAULT
        }
        return result
    }
    private func filterPlayer2Name(value:String) -> String {
        var result = filterPlayerName(value: value)
        if (result == "" || result == NIMGame.PLAYER_IA_NAME) {
            result = NIMGame.PLAYER_2_NAME_DEFAULT
        }
        return result
    }
    private func setScores(scores:[String:Int]) {
        _userDefaults.set(scores, forKey: NIMGame.SCORES_KEY)
    }

    func newGame() {
        _remainingMatches = getMaxNbMatchesSettings()
        _maxMatches = getMaxNbMatchesSettings()
        _currentPlayer = getWhoPlaysFirst()
     }
    func play(nbMatchesSelected:Int) {
        if (_currentPlayer == 2 && !getHumanVsHumanSetting()) {
            playIA()
        } else {
            removeMatches(nbMatches: nbMatchesSelected)
        }
    }
    func isGameOver() -> Bool {
        return remainingMatches <= 0
    }
    func hasStarted() -> Bool {
        return remainingMatches != _maxMatches
    }
    func resetSettings() {
        _userDefaults.removeObject(forKey: NIMGame.PLAYER_1_NAME_KEY)
        _userDefaults.removeObject(forKey: NIMGame.PLAYER_2_NAME_KEY)
        _userDefaults.removeObject(forKey: NIMGame.CHOICE_HUMAN_VS_HUMAN_KEY)
        _userDefaults.removeObject(forKey: NIMGame.MAX_NB_MATCHES_KEY)
        _userDefaults.removeObject(forKey: NIMGame.WHO_PLAYS_FIRST_KEY)
    }
    func resetScores() {
        _userDefaults.removeObject(forKey: NIMGame.SCORES_KEY)
    }
	func getScores() -> [String:Int]? {
        var result:[String:Int]?
        if (_userDefaults.dictionary(forKey: NIMGame.SCORES_KEY) as? [String : Int] != nil) {
            result = _userDefaults.dictionary(forKey: NIMGame.SCORES_KEY) as? [String : Int]
        }
        return result
	}
    func setPlayer1Name(value:String) -> String {
        let result = filterPlayer1Name(value:value)
        _userDefaults.set(result, forKey: NIMGame.PLAYER_1_NAME_KEY)
        return result
    }
	func getPlayer1Name() -> String {
        var playerName:String
        // Sets the default value if not already set
        if (_userDefaults.string(forKey: NIMGame.PLAYER_1_NAME_KEY) == nil) {
            playerName = NIMGame.PLAYER_1_NAME_DEFAULT
        } else {
            playerName = _userDefaults.string(forKey: NIMGame.PLAYER_1_NAME_KEY)!
        }
		return playerName
	}
    func setPlayer2Name(value:String) -> String {
        let userDefaults:UserDefaults = UserDefaults.standard
        let result = filterPlayer2Name(value:value)
        userDefaults.set(result, forKey: NIMGame.PLAYER_2_NAME_KEY)
        return result
    }
    func getPlayer2Name() -> String {
        var playerName:String
        if (getHumanVsHumanSetting()) {
            // Sets the default value if not already set
            if (_userDefaults.string(forKey: NIMGame.PLAYER_2_NAME_KEY) == nil || _userDefaults.string(forKey: NIMGame.PLAYER_2_NAME_KEY) == NIMGame.PLAYER_IA_NAME) {
                playerName = NIMGame.PLAYER_2_NAME_DEFAULT
            } else {
                playerName = _userDefaults.string(forKey: NIMGame.PLAYER_2_NAME_KEY)!
            }
        } else {
            playerName = NIMGame.PLAYER_IA_NAME
        }
        return playerName
    }
    func getCurrentPlayerName() -> String {
        var playerName:String
        if (_currentPlayer == 1) {
            playerName = getPlayer1Name()
        } else {
            playerName = getPlayer2Name()
        }
        return playerName
    }
    func setHumanVsHumanSetting(value:Bool) {
        _userDefaults.set(value, forKey: NIMGame.CHOICE_HUMAN_VS_HUMAN_KEY)
    }
    func getHumanVsHumanSetting() -> Bool {
        if (_userDefaults.object(forKey: NIMGame.CHOICE_HUMAN_VS_HUMAN_KEY) == nil) {
            return true
        } else {
            return _userDefaults.bool(forKey: NIMGame.CHOICE_HUMAN_VS_HUMAN_KEY)
        }
    }
    func setMaxNbMatchesSettings(value:Int) {
        _userDefaults.set(value, forKey: NIMGame.MAX_NB_MATCHES_KEY)
    }
    func getMaxNbMatchesSettings() -> Int {
        var maxNbMatches:Int = _userDefaults.integer(forKey: NIMGame.MAX_NB_MATCHES_KEY)
		// Sets the default value if not already set
        if (maxNbMatches == 0) {
            maxNbMatches = NIMGame.LIMIT_MAX_MATCHES
		}
        return maxNbMatches
    }
    func setWhoPlaysFirst(value:Int) {
        _userDefaults.set(value, forKey: NIMGame.WHO_PLAYS_FIRST_KEY)
    }
    func getWhoPlaysFirst() -> Int {
        var whoPlaysFirst:Int = _userDefaults.integer(forKey: NIMGame.WHO_PLAYS_FIRST_KEY)
        // Sets the default value if not already set
        if (whoPlaysFirst == 0) {
            whoPlaysFirst = 1
        } else if (whoPlaysFirst == 3) {
            whoPlaysFirst = generateRandomNumber(min:1, max:2)
        }
        return whoPlaysFirst
    }
}
