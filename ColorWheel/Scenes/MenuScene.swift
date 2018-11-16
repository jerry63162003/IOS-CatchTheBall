//
//  MenuScene.swift
//  ColorWheel
//
//  Created by Angela Rucci on 7/6/18.
//  Copyright © 2018 Angela Rucci. All rights reserved.
//

import SpriteKit

/// This scene is shown right after launch screen.
/// It will display High score and most recent score.
/// When user taps on this scene it will lead to Game
/// scene and the game will begin. 
class MenuScene: SKScene {
    
    let gameConfig = GameConfig.shared
    var modeSprite = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 15/255, green: 38/255, blue: 62/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    
    /// Adds color wheel logo to main menu scene
    func addLogo() {
        let background = SKSpriteNode(imageNamed: "首页bg")
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 0
        addChild(background)
    }
    
    /// Adds "Tap to play", "High Score", and "Recent high score" labels to menu scene
    func addLabels() {
        
//        let recentScoreLabel = createTextNode(text: "Recent Score: \(UserDefaults.standard.integer(forKey: "recent_score"))", nodeName: "RecentScoreLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(35.0), fontColor: UIColor.white)
//        recentScoreLabel.zPosition = 1
//        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentScoreLabel.frame.size.height*2)
//        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentScoreLabel.frame.size.height*2)
//        addChild(recentScoreLabel)
        
        var modeImage = ""
        switch gameConfig.gameLevel {
        case .Easy:
            modeImage = "难度简单"
            break
        case .Mid:
            modeImage = "难度中等"
            break
        case .Diff:
            modeImage = "难度困难"
            break
        }
        
        modeSprite = SKSpriteNode(imageNamed: modeImage)
        modeSprite.name = "modeSelect"
        modeSprite.zPosition = 1
        modeSprite.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        
        let gameExplainSprite = SKSpriteNode(imageNamed: "77")
        gameExplainSprite.name = "gameExplain"
        gameExplainSprite.zPosition = 1
        gameExplainSprite.position = CGPoint(x: frame.midX, y: frame.midY - 30)
        
        let startGameSprite = SKSpriteNode(imageNamed: "Group 2")
        startGameSprite.name = "startGame"
        startGameSprite.zPosition = 1
        if frame.height == 480 {
            startGameSprite.position = CGPoint(x: frame.midX, y: frame.midY - 120)
        }else {
            startGameSprite.position = CGPoint(x: frame.midX, y: frame.midY - 140)
        }
        
        let highScoreLabel = createTextNode(text: "最高分: \(GameConfig.shared.gameScore)", nodeName: "HighScoreLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(35.0), fontColor: UIColor.white)
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*7)
        if frame.height == 480 {
            highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 30 - highScoreLabel.frame.size.height*7)
        }else {
            highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*7)
        }
        
        addChild(modeSprite)
        addChild(gameExplainSprite)
        animatePule(label: startGameSprite)
        addChild(highScoreLabel)
        addChild(startGameSprite)
    }
    
    func resetmodeView() {
        var modeImage = ""
        switch gameConfig.gameLevel {
        case .Easy:
            modeImage = "难度简单"
            break
        case .Mid:
            modeImage = "难度中等"
            break
        case .Diff:
            modeImage = "难度困难"
            break
        }
        
        guard let image = UIImage(named: modeImage) else {
            return
        }
        modeSprite.texture = SKTexture(image: image)
    }
    
    func showModeSelect() {
        let backColorSprite = SKSpriteNode(color: .black, size: frame.size)
        backColorSprite.name = "bg"
        backColorSprite.alpha = 0.7
        backColorSprite.zPosition = 9
        backColorSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let backGroud = SKSpriteNode(imageNamed: "弹窗")
        backGroud.name = "modeSelectView"
        backGroud.zPosition = 10
        backGroud.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let close = SKSpriteNode(imageNamed: "叉")
        close.name = "closeSelect"
        close.zPosition = 11
        close.position = CGPoint(x: 100, y: 140)
        backGroud.addChild(close)
        
        let easySprite = SKSpriteNode(imageNamed: "简单")
        easySprite.zPosition = 11
        easySprite.name = "easy"
        easySprite.position = CGPoint(x: 0, y: -10)
        backGroud.addChild(easySprite)
        
        let midSprite = SKSpriteNode(imageNamed: "中等")
        midSprite.zPosition = 11
        midSprite.name = "mid"
        midSprite.position = CGPoint(x: 0, y: -60)
        backGroud.addChild(midSprite)
        
        let diffSprite = SKSpriteNode(imageNamed: "困难")
        diffSprite.zPosition = 11
        diffSprite.name = "diff"
        diffSprite.position = CGPoint(x: 0, y: -110)
        backGroud.addChild(diffSprite)
        
        switch gameConfig.gameLevel {
        case .Easy:
            easySprite.texture = SKTexture(imageNamed: "简单-点击后")
            animatePule(label: easySprite)
            break
        case .Mid:
            midSprite.texture = SKTexture(imageNamed: "中等-点击后")
            animatePule(label: midSprite)
            break
        case .Diff:
            diffSprite.texture = SKTexture(imageNamed: "困难-点击后")
            animatePule(label: diffSprite)
            break
        }
        
        //actions
        let action = SKAction.run {
            backGroud.setScale(0.1)
            self.addChild(backColorSprite)
            self.addChild(backGroud)
        }
        run(action)
        
        let scaleAction = SKAction.scale(to: 1, duration: 0.3)
        backGroud.run(scaleAction)
    }
    
    func showPayExplain() {
        let backColorSprite = SKSpriteNode(color: .black, size: frame.size)
        backColorSprite.name = "bg"
        backColorSprite.alpha = 0.7
        backColorSprite.zPosition = 9
        backColorSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let backGroud = SKSpriteNode(imageNamed: "玩法说明弹窗")
        backGroud.name = "explainSelectView"
        backGroud.zPosition = 10
        backGroud.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let close = SKSpriteNode(imageNamed: "叉")
        close.name = "closeExplain"
        close.zPosition = 11
        close.position = CGPoint(x: 100, y: 140)
        backGroud.addChild(close)
        
        let labelNode = SKLabelNode.init(text: "不同颜色的球落下，需要\n用对应的球篓接住；\n难度越高，球的颜色越多，\n球速也越快。\n开始表演吧！")
        if #available(iOS 11.0, *) {
            labelNode.numberOfLines = 0
        } else {
            // Fallback on earlier versions
        }
        labelNode.fontName = "AvenirNext-Bold"
        labelNode.fontSize = 16
        labelNode.zPosition = 11
        labelNode.position = CGPoint(x: 10, y: -100)
        backGroud.addChild(labelNode)
        
        let knowSprite = SKSpriteNode(imageNamed: "知道啦")
        knowSprite.zPosition = 11
        knowSprite.name = "know"
        knowSprite.position = CGPoint(x: 0, y: -150)
        backGroud.addChild(knowSprite)
        
        //actions
        let action = SKAction.run {
            backGroud.setScale(0.1)
            self.addChild(backColorSprite)
            self.addChild(backGroud)
        }
        run(action)
        
        let scaleAction = SKAction.scale(to: 1, duration: 0.3)
        backGroud.run(scaleAction)
    }
    
    
    /// When user touches screen, scene will change to Game Scene and game will begin 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            //begin game
            if atPoint(touchLocation).name == "startGame" {
                let gameScene = GameScene(size: view!.bounds.size)
                view!.presentScene(gameScene, transition: .fade(withDuration: 0.5))
            }
            
            if atPoint(touchLocation).name == "modeSelect" {
                showModeSelect()
            }
            
            if atPoint(touchLocation).name == "gameExplain" {
                showPayExplain()
            }
            
            if atPoint(touchLocation).name == "easy" || atPoint(touchLocation).name == "mid" || atPoint(touchLocation).name == "diff" || atPoint(touchLocation).name == "closeSelect" {
                guard let name = atPoint(touchLocation).name else {
                    return
                }
                guard let modeSelectView = childNode(withName: "modeSelectView") else {
                    return
                }
                
                if name == "closeSelect" {
                    let removeAction = SKAction.run {
                        modeSelectView.removeFromParent()
                        self.childNode(withName: "bg")?.removeFromParent()
                    }
                    let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                    modeSelectView.run(SKAction.sequence([scaleAction, removeAction]))
                    return
                }
                
                guard let level = GameLevel(rawValue: name) else {
                    return
                }
                
                gameConfig.gameLevel = level
                
                let removeAction = SKAction.run {
                    modeSelectView.removeFromParent()
                    self.childNode(withName: "bg")?.removeFromParent()
                }
                let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                modeSelectView.run(SKAction.sequence([scaleAction, removeAction]))
                
                resetmodeView()
            }
            
            if atPoint(touchLocation).name == "know" || atPoint(touchLocation).name == "closeExplain" {
                guard let explainView = childNode(withName: "explainSelectView") else {
                    return
                }
                
                let removeAction = SKAction.run {
                    explainView.removeFromParent()
                    self.childNode(withName: "bg")?.removeFromParent()
                }
                let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                explainView.run(SKAction.sequence([scaleAction, removeAction]))
            }
        }
        
    }

}
