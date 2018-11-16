//
//  GameConfig.swift
//  ColorWheel
//
//  Created by roy on 2018/7/12.
//  Copyright © 2018年 Angela Rucci. All rights reserved.
//

import UIKit

enum GameLevel: String {
    case Easy = "easy"
    case Mid = "mid"
    case Diff = "diff"
}

let uGameLevel = "gameLevel"
let uGameScore = "gameScore"

class GameConfig: NSObject {
    
    static let shared = GameConfig()
    
    var gameLevel: GameLevel = (UserDefaults.standard.string(forKey: uGameLevel) != nil) ? GameLevel(rawValue: UserDefaults.standard.string(forKey: uGameLevel)!)! : .Easy {
        didSet {
            UserDefaults.standard.set(gameLevel.rawValue, forKey: uGameLevel)
            UserDefaults.standard.synchronize()
        }
    }
    
    private var _gameScore: Int = 0
    var gameScore: Int {
        set {
            _gameScore = newValue
            UserDefaults.standard.set(_gameScore, forKey: uGameScore + gameLevel.rawValue)
            UserDefaults.standard.synchronize()
        }
        
        get {
            return UserDefaults.standard.integer(forKey: uGameScore + gameLevel.rawValue)
        }
    }
    
    func getGravity() -> CGFloat {
        switch gameLevel {
        case .Easy:
            return -1
        case .Mid:
            return -1.5
        case .Diff:
            return -2
        }
    }
    
    func getAngleAndTime() -> (CGFloat, Double) {
        switch gameLevel {
        case .Easy:
            return (.pi / 2, 0.25)
        case .Mid:
            return (2 * .pi / 5, 0.2)
        case .Diff:
            return (.pi / 3, 0.167)
        }
    }
    
    func getColorNumber() -> UInt32 {
        switch gameLevel {
        case .Easy:
            return 4
        case .Mid:
            return 5
        case .Diff:
            return 6
        }
    }
    
    func getBasketNameStr() -> String {
        switch gameLevel {
        case .Easy:
            return "4框"
        case .Mid:
            return "5框"
        case .Diff:
            return "6框"
        }
    }
    
}
