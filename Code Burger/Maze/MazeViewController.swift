//
//  MazeViewController.swift
//  Code Burger
//
//  Created by Finley Khouwira on 18/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MazeViewController: UIViewController, GameManager {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MazeStage1") as? MazeStage {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.gameManager = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func backToStageSelect() {
        dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
