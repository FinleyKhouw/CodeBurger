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
import AVFoundation

class GameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    let userDef = UserDefaults.standard
    let stage: [Int] = [1,2,3,4,5,6,7,8,9]
    let stageStatus: [Bool] = [false, false, false,false,false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSound = Bundle.main.path(forResource: "backsound", ofType: "mp3")
        userDef.set(stage, forKey: "stageArray")
        userDef.set(stageStatus, forKey: "stageStatus")
        
        if (self.view as! SKView?) != nil {
            // Load the SKScene from 'GameScene.sks'
            if let view = self.view as! SKView? {
                let scene = Start(size: view.frame.size)
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioSound!))
                } catch {
                    print(error)
                }
                audioPlayer.numberOfLoops = -1
                audioPlayer.play()
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
