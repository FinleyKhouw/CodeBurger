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
    
    let pausePage = SKSpriteNode(imageNamed: "pausepage")
    let userDef = UserDefaults.standard
    var reuseIdentifier:[String] = ["sequenceStage", "commandStage", "mazeStage"]
    
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
            } else if touchedNode == burger {
                if let view = self.view {
                    // Create an effects node with a gaussian blur filter
                    let effectsNode = SKEffectNode()
                    let filter = CIFilter(name: "CIGaussianBlur")
                    // Set the blur amount. Adjust this to achieve the desired effect
                    let blurAmount = 10.0
                    filter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
                    
                    effectsNode.filter = filter
                    effectsNode.position = self.view!.center
                    effectsNode.blendMode = .alpha
                    
                    // Create a sprite
                    let texture = SKTexture(imageNamed: "Spaceship")
                    let sprite = SKSpriteNode(texture: texture)
                    
                    // Add the sprite to the effects node. Nodes added to the effects node
                    // will be blurred
                    effectsNode.addChild(sprite)
                    // Add the effects node to the scene
                    self.addChild(effectsNode)
                    
                    // Create another sprite
                    let sprite2 = SKSpriteNode(texture: texture)
                    sprite2.position = self.view!.center
                    sprite2.size = CGSize(width:64, height:64);
                    sprite2.zPosition = 100
                    
                    // Add the sprite to the scene. Nodes added to the scene won't be blurred
                    self.addChild(sprite2)
                    
                    
                    pausePage.zPosition = 2
                    pausePage.size = CGSize(width: 400, height: 400)
                    pausePage.position = CGPoint(x: size.width/2, y: size.height/2)
                    addChild(pausePage)
                
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
