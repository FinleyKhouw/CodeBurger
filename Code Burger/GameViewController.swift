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

    var hasCharacter = false
    var selectedCharacter: String = "MALE"
    var stageIndex = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioSound = Bundle.main.path(forResource: "backsound", ofType: "mp3")
        
        // Save Stage Data if data is nil so save it
        getData()
        
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
    
    func getData() {
        if userDef.bool(forKey: "hasCharacter") == nil {
            userDef.set(hasCharacter, forKey: "hasCharacter")
        }
        
        if userDef.string(forKey: "selectedCharacter") == nil {
            userDef.set(selectedCharacter, forKey: "selectedCharacter")
        }
        
        if userDef.integer(forKey: "stageIndex") == nil {
            userDef.set(12, forKey: "stageIndex")
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

