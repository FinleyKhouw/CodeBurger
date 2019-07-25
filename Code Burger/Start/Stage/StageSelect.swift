//
//  StageSelect.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class StageSelect: SKScene {
    
    let responseMessages = [
        0: "sequenceStage",
        1: "sequenceStage",
        2: "sequenceStage",
        3: "commandStage",
        4: "commandStage",
        5: "commandStage",
        6: "commandStage",
        7: "mazeStage",
        8: "mazeStage",
        9: "mazeStage",
        10: "mazeStage", ]
    
    var stageTableView = GameRoomTableView()
    let backButton = SKSpriteNode(imageNamed: "back")
    let character = SKSpriteNode(imageNamed: "Stage Select Character")
    let bubbleChat = SKSpriteNode(imageNamed: "Bubble Chat")
    let helloText = SKLabelNode(text: "Woooaaaaa...")
    let userDef = UserDefaults.standard
    
    override func didMove(to view: SKView) {
//        stageTableView.register(StageTableCell.self, forCellReuseIdentifier: "stageCell")
        
        addView()
    }
    
    func addView()  {
        scene?.backgroundColor = UIColor.white
        
        stageTableView.register(UINib.init(nibName: "StageTableViewCell", bundle: nil), forCellReuseIdentifier: "stageCell")
        stageTableView.rowHeight = 150
        stageTableView.estimatedRowHeight = 50
        stageTableView.backgroundColor = UIColor.black
        stageTableView.frame = CGRect(x:size.width/2, y:0, width: size.width/2, height:size.height)
        self.scene?.view?.addSubview(stageTableView)
        stageTableView.reloadData()
        stageTableView.stageProtocols = self
        
        character.size = CGSize(width: size.width/4, height: size.width/4)
        character.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        character.position = CGPoint(x: size.width/4, y: size.height/2)
        addChild(character)
        
        bubbleChat.size = CGSize(width: size.width/3, height: size.height/6)
        bubbleChat.anchorPoint = CGPoint(x: 0.5, y: 0)
        bubbleChat.position = CGPoint(x: size.width/4, y: size.height/3 + size.height/5)
        addChild(bubbleChat)
        
        helloText.fontSize = 35
        helloText.fontName = "Chalkduster"
        helloText.zPosition = 3
        helloText.color = .black
        helloText.colorBlendFactor = 1.0
        helloText.position = CGPoint(x:size.width/4 , y: size.height/2 + (size.height/2)/4)
        addChild(helloText)
        
        backButton.position = CGPoint(x: size.width/1 - (size.width * 0.9) , y: size.height * 0.9)
        backButton.size = CGSize(width: 100, height: 100)
        addChild(backButton)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            let touch: UITouch = touches.first as! UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == backButton {
                if let view = self.view {
                    if userDef.bool(forKey: "hasCharacter") {
                        stageTableView.removeFromSuperview()
                        let scene = Start(size: view.frame.size)
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene,transition: SKTransition.fade(withDuration: 1))
                        view.ignoresSiblingOrder = true
                    } else {
                        stageTableView.removeFromSuperview()
                        let scene = CharacterSelect(size: view.frame.size)
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene,transition: SKTransition.fade(withDuration: 1))
                        view.ignoresSiblingOrder = true
                    }
                }
            }
        }
    }
}

extension StageSelect : StageProtocols {
    
    func moveScene(_ indexPath: IndexPath) {
        if self.view != nil {
            //if userDef.integer(forKey: "stageIndex") >= indexPath.row {
                
                print("indexPath.row: \(indexPath.row)")
                
                if indexPath.row < 3 {
                    // Sequence
                    if let identifier = responseMessages[indexPath.row] {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let sequenceController = storyBoard.instantiateViewController(withIdentifier: identifier)
                        self.view?.window?.rootViewController!.present(sequenceController, animated: true, completion: nil)
                    }
                } else if indexPath.row < 7 {
                    // Command
                    if let identifier = responseMessages[indexPath.row] {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let commandGameViewController = storyBoard.instantiateViewController(withIdentifier: identifier) as! CommandGameViewController
                        commandGameViewController.stageIndex = indexPath.row
                        self.view?.window?.rootViewController!.present(commandGameViewController, animated: true, completion: nil)
                    }
                } else if indexPath.row < 12 {
                    // Maze
                    if let identifier = responseMessages[indexPath.row] {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let mazeViewController = storyBoard.instantiateViewController(withIdentifier: identifier) as! MazeViewController
                        
                        self.view?.window?.rootViewController!.present(mazeViewController, animated: true, completion: nil)
                    }
                }
                
                
                
                
                
                
                
                
                
                
//                
//            } else {
//                // U Cant enter this stage. Finish it first
//            }
        }
    }
}
