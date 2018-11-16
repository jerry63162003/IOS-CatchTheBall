//
//  GameOverScene.swift
//  ColorWheel
//
//  Created by roy on 2018/7/16.
//  Copyright © 2018年 Angela Rucci. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var scoreLabel = SKLabelNode()
    var score = 0
    var isNewRecord = false {
        didSet {
            if isNewRecord {
                addNewRecord()
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addNodes()
    }
    
    func addNodes() {
        let backgroud = SKSpriteNode(imageNamed: "结算背景")
        backgroud.size = CGSize(width: frame.width, height: frame.height)
        backgroud.zPosition = 0
        addChild(backgroud)
        
        let again = SKSpriteNode(imageNamed: "再来一局")
        again.name = "again"
        again.zPosition = 1
        again.position = CGPoint(x: -60, y: -80)
        addChild(again)
        
        let back = SKSpriteNode(imageNamed: "返回首页")
        back.name = "back"
        back.zPosition = 1
        back.position = CGPoint(x: 60, y: -80)
        addChild(back)
        
        scoreLabel = createTextNode(text: "当前得分: \(score)", nodeName: "HighScoreLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(35.0), fontColor: UIColor.white)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
    }
    
    func addNewRecord() {
        let record = SKSpriteNode(imageNamed: "新纪录")
        record.zPosition = 2
        record.position = CGPoint(x: 120, y: 67)
        addChild(record)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation).name == "back" {
                let menuScene = MenuScene(size: CGSize(width: frame.width, height: frame.height))
                view!.presentScene(menuScene, transition: .fade(withDuration: 0.5))
            }
            if atPoint(touchLocation).name == "again" {
                let gameScene = GameScene(size: CGSize(width: frame.width, height: frame.height))
                view!.presentScene(gameScene, transition: .fade(withDuration: 0.5))
            }
        }
    }
}
