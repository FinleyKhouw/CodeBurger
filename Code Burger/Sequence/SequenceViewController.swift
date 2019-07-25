//
//  GameViewController.swift
//  Sorting Game CodeBurger
//
//  Created by Mirza Fachreza 2 on 09/07/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SequenceViewController: UIViewController, GameManager {

    var stageIndex = 0 // 0-2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'PrologueScene.sks'
            
            
            if stageIndex == 0 {
                if let scene = SKScene(fileNamed: "SequenceStageOne") as? SequenceStageOne {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill                    
                    scene.gameManager = self
                    // Present the scene
                    view.presentScene(scene)
                }
            } else if stageIndex == 1 {
                if let scene = SKScene(fileNamed: "SequenceStageTwo") as? SequenceStageTwo {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    scene.gameManager = self
                    // Present the scene
                    view.presentScene(scene)
                }
            } else if stageIndex == 2 {
                if let scene = SKScene(fileNamed: "SequenceStageThree") as? SequenceStageThree {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    scene.gameManager = self
                    // Present the scene
                    view.presentScene(scene)
                }
            } else {
                print("invalid stageIndex")
            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func backToStageSelect() {
        dismiss(animated: true)
    }

}
