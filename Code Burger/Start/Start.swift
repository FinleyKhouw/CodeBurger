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
    let burger = SKSpriteNode(imageNamed: "burger")
    let playButton = SKSpriteNode(imageNamed: "play")
    let stageButton = SKSpriteNode(imageNamed: "stage-select")
    let userDef = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        // iPad 10.5 = total(x = 1100, y = 850)
        setView()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setView() {
        burger.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(burger)
        
        playButton.size = CGSize(width: 100, height: 100)
        playButton.position = CGPoint(x: size.width/2, y: size.height/4)
        playButton.name = "playButton"
        addChild(playButton)
        
        stageButton.size = CGSize(width: 150, height: 60)
        stageButton.position = CGPoint(x: size.width/2, y: size.height/8)
        stageButton.name = "stageButton"
        addChild(stageButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touch: UITouch = touches.first as! UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == playButton {
                    if let view = self.view {
                        if userDef.bool(forKey: "hasCharacter") {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let sequenceController = storyBoard.instantiateViewController(withIdentifier: "sequenceStage")
                            self.view?.window?.rootViewController!.present(sequenceController, animated: true, completion: nil)
                            
//                            let scene = StageSelect(size: view.frame.size)
//                            
//                            scene.scaleMode = .aspectFill
//                            view.presentScene(scene,transition: SKTransition.fade(withDuration: 0.5))
//                            view.ignoresSiblingOrder = true
//                            
//                            view.showsFPS = false
//                            view.showsNodeCount = true
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
}
