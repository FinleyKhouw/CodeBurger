//
//  GameScene.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

class Start: SKScene {
    let character = SKSpriteNode(imageNamed: "Main Menu Character")
    let bubbleChat = SKSpriteNode(imageNamed: "Bubble Chat")
    let playButton = SKSpriteNode(imageNamed: "play")
    let stageButton = SKSpriteNode(imageNamed: "menu")
    let backgroundImage = SKSpriteNode(imageNamed: "Background")
    
    let helloText = SKLabelNode(text: "Hello")
    
    let pausePage = SKSpriteNode(imageNamed: "pausepage")
    let userDef = UserDefaults.standard
    var reuseIdentifier:[String] = ["sequenceStage", "commandStage", "mazeStage"]
    
    override func didMove(to view: SKView) {
        // iPad 10.5 = total(x = 1100, y = 850)
        
        setView()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setView() {
        character.size = CGSize(width: size.width/4, height: size.height/2.5)
        character.anchorPoint = CGPoint(x: 1.0, y: 0)
        character.position = CGPoint(x: size.width, y: 0)
        addChild(character)
        
        helloText.fontSize = 35
        helloText.fontName = "Chalkduster"
        helloText.zPosition = 3
        helloText.color = .black
        helloText.colorBlendFactor = 1.0
        helloText.position = CGPoint(x:size.width/2 + size.width/3, y: size.height/2)
        addChild(helloText)
        
        bubbleChat.size = CGSize(width: size.width/3, height: size.height/6)
        bubbleChat.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        bubbleChat.position = CGPoint(x: size.width, y: size.height/2)
        addChild(bubbleChat)
        
 
        
        playButton.size = CGSize(width: 200, height: 200)
        playButton.position = CGPoint(x: size.width/2, y: size.height/2)
        playButton.name = "playButton"
        addChild(playButton)
        
        stageButton.size = CGSize(width: 150, height: 60)
        stageButton.position = CGPoint(x: size.width/2, y: size.height/8)
        stageButton.name = "stageButton"
        addChild(stageButton)
        
        backgroundImage.zPosition = -2
        backgroundImage.size = CGSize(width: size.width, height: size.height)
        backgroundImage.anchorPoint = CGPoint(x: 0, y: 1.0)
        backgroundImage.position = CGPoint(x: 0, y: size.height)
        addChild(backgroundImage)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touch: UITouch = touches.first as! UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == playButton {
                    if let view = self.view {
                        if userDef.bool(forKey: "hasCharacter") {
                            switch userDef.integer(forKey: "stageIndex") {
                            case 0:
                                print(reuseIdentifier[0])
                                changeScene(resueIdentifier: reuseIdentifier[0])
                            case 1:
                                changeScene(resueIdentifier: reuseIdentifier[1])
                            case 2:
                                changeScene(resueIdentifier: reuseIdentifier[2])
                            default:
                                print("no index detected")
                            }
                        } else {
                            let scene = CharacterSelect(size: view.frame.size)
                            
                            scene.scaleMode = .aspectFill
                            view.presentScene(scene,transition: SKTransition.fade(withDuration: 0.5))
                            view.ignoresSiblingOrder = true
                            
                            view.showsFPS = false
                            view.showsNodeCount = true
                        }
                }
            } else if touchedNode == stageButton {
                if let view = self.view {
                    if userDef.bool(forKey: "hasCharacter") {
                        let scene = StageSelect(size: view.frame.size)
                        
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene,transition: SKTransition.fade(withDuration: 0.5))
                        view.ignoresSiblingOrder = true
                        
                        view.showsFPS = false
                        view.showsNodeCount = true
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func changeScene(resueIdentifier: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sequenceController = storyBoard.instantiateViewController(withIdentifier:
        resueIdentifier)
        self.view?.window?.rootViewController!.present(sequenceController, animated: true, completion: nil)
    }
}
