//
//  NIMGame.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation

class NIMGame {
    public static let maxMatches:Int = NIMGame.getMaxNbMatchesSettings()
    public static let maxRemovableMatches:Int = 3
    
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
        }
    }
    private func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max - min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
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
        if (maxNbMatches == 0) {
            maxNbMatches = 20
        }
        return maxNbMatches
    }
}
