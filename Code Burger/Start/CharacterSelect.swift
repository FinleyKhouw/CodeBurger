//
//  CharacterSelect.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class CharacterSelect: SKScene {
    
    let maleCharacter = SKSpriteNode(imageNamed: "Boy Char")
    let femaleCharacter = SKSpriteNode(imageNamed: "Girl")
    let backButton = SKSpriteNode(imageNamed: "back")
    let playButton = SKSpriteNode(imageNamed: "play")
    var characterIsSelected: Bool = false
    let userDef = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        characterIsSelected = false
        setView()
    }
    
    func setView() {
        maleCharacter.position = CGPoint(x: size.width/4, y: size.height/2)
        maleCharacter.size = CGSize(width: 200, height: 200)
        addChild(maleCharacter)
        
        femaleCharacter.position = CGPoint(x: (size.width/2) + (size.width/4), y: size.height/2)
        femaleCharacter.size = CGSize(width: 250, height: 250)
        addChild(femaleCharacter)
        
        backButton.position = CGPoint(x: size.width/1 - (size.width * 0.9) , y: size.height * 0.9)
        backButton.size = CGSize(width: 100, height: 100)
        addChild(backButton)
        
        playButton.size = CGSize(width: 100, height: 100)
        playButton.position = CGPoint(x: size.width/2, y: size.height/4)
        playButton.name = "playButton"
        addChild(playButton)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let startScene = Start(fileNamed: "Start")
//        startScene?.scaleMode = .aspectFill
//        self.view?.presentScene(startScene!, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            let touch: UITouch = touches.first as! UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == backButton {
                if let view = self.view {
                    let scene = Start(size: view.frame.size)
                    scene.scaleMode = .aspectFill
                    view.presentScene(scene,transition: SKTransition.fade(withDuration: 1))
                    view.ignoresSiblingOrder = true
                }
            } else if touchedNode == maleCharacter {
                characterIsSelected = true
                let fadeIn = SKAction.scale(to: 1.3, duration: 0.5)
                let fadeNormal = SKAction.scale(to: 1, duration: 0.5)
                let fadeOut = SKAction.scale(to: 0.8, duration: 0.5)
                let sequence = SKAction.sequence([fadeIn, fadeNormal, fadeOut])
                let repeatAnimation = SKAction.repeatForever(sequence)
                maleCharacter.run(repeatAnimation)
                femaleCharacter.removeAllActions()
            } else if touchedNode == femaleCharacter {
                characterIsSelected = true
                let fadeIn = SKAction.scale(to: 1.3, duration: 0.50)
                let fadeNormal = SKAction.scale(to: 1, duration: 0.50)
                let fadeOut = SKAction.scale(to: 0.8, duration: 0.50)
                let sequence = SKAction.sequence([fadeIn, fadeNormal, fadeOut])
                let repeatAnimation = SKAction.repeatForever(sequence)
                femaleCharacter.run(repeatAnimation)
                maleCharacter.removeAllActions()
            } else if touchedNode == playButton {
                if let view = self.view {
                    if characterIsSelected == true {
                        let scene = StageSelect(size: view.frame.size)
                        scene.scaleMode = .aspectFill
                        userDef.set(true, forKey: "hasCharacter")
                        view.presentScene(scene,transition: SKTransition.fade(withDuration: 1))
                        view.ignoresSiblingOrder = true
                    }
                }
            }
        }
    }
}

