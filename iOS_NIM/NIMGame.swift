//
//  NIMGame.swift
//  iOS_NIM
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import Foundation

class NIMGame {
    public static let maxMatches:Int = 20
    public static let maxRemovableMatches:Int = 3
    
    private var humanVsHuman:Bool = false
    public var remainingMatches:Int = maxMatches
    public var currentPlayer:Int = 1
    public var maxInput:Int {
        get{
            return min(remainingMatches, NIMGame.maxRemovableMatches)
        }
    }
    init(humanVsHuman:Bool) {
        newGame(hVsH: humanVsHuman)
    }
    func newGame(hVsH:Bool) {
        humanVsHuman = hVsH
        remainingMatches = 20
        currentPlayer = generateRandomNumber(min:1, max:2)
    }
    func play(nbMatchesSelected:Int) {
        if (currentPlayer == 2 && !humanVsHuman) {
            playIA()
        } else {
            removeMatches(nbMatches: nbMatchesSelected)
        }
    }
    func isGameOver() -> Bool {
        return remainingMatches == 0
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
}
