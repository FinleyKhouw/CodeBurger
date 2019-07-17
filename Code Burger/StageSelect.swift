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
    
    var stageTableView = GameRoomTableView()
    let backButton = SKSpriteNode(imageNamed: "backbutton")
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
    
//    func moveStage() {
//        if let view = self.view {
//                stageTableView.removeFromSuperview()
//                let scene = CharacterSelect(size: view.frame.size)
//                scene.scaleMode = .aspectFill
//                view.presentScene(scene,transition: SKTransition.fade(withDuration: 1))
//                view.ignoresSiblingOrder = true
//        }
//    }
}
