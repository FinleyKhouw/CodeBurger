//
//  GameViewController.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.view as! SKView?) != nil {
            // Load the SKScene from 'GameScene.sks'
            if let view = self.view as! SKView? {
                let scene = MazeStage(fileNamed: "MazeStage")
                scene!.scaleMode = .aspectFill
                view.presentScene(scene!)
                view.ignoresSiblingOrder = false
                
                view.showsFPS = false
                view.showsNodeCount = true
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
