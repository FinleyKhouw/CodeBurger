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

class SequenceViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'PrologueScene.sks'
            if let scene = SKScene(fileNamed: "SequenceStageOne") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
