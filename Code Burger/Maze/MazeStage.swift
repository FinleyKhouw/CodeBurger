//
//  MazeStage.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import UIKit

enum Command {
    case left, right, up, down
}

enum WallPlacement {
    case left, right, up, down
}

class MazeStage: SKScene {
    
    // MARK: Command Assets
    
    var playButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    var leftTapped = SKSpriteNode()
    var rightTapped = SKSpriteNode()
    var upTapped = SKSpriteNode()
    var downTapped = SKSpriteNode()
    var lineSeperator = SKShapeNode()
    
    // MARK: Stage Assets
    
    var character = SKSpriteNode()
    var wall1 = SKSpriteNode()
    var wall2 = SKSpriteNode()
    var wall3 = SKSpriteNode()
    var wall4 = SKSpriteNode()
    var wall5 = SKSpriteNode()
    var wall6 = SKSpriteNode()
    var tiles = SKSpriteNode()
    
    // MARK : Location, Position, and Size
    
    var currentPosition = 0
    var commandLocation = CGPoint(x: 50, y: 900)
    var characterLocation = CGPoint(x: 550, y: 840)
    var commandNodeSize = CGSize(width: 75, height: 75)
    
    // Command Configuration
    
    var commands: [Command] = []
    var wallPlacements: [WallPlacement] = []
    var commandNodes: [SKSpriteNode] = []
    
    // Movement Action (SKAction)
    
    let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 220), duration: 1)
    let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -220), duration: 1)
    let moveLeft = SKAction.move(by: CGVector(dx: -220, dy: 0), duration: 1)
    let moveRight = SKAction.move(by: CGVector(dx: 220, dy: 0), duration: 1)
    let moveHome = SKAction.move(to: CGPoint(x: 550, y: 840), duration: 0.001)
    
    let moveHalfUp = SKAction.move(by: CGVector(dx: 0, dy: 30), duration: 0.25)
    let moveHalfDown = SKAction.move(by: CGVector(dx: 0, dy: -30), duration: 0.25)
    let moveHalfLeft = SKAction.move(by: CGVector(dx: -30, dy: 0), duration: 0.25)
    let moveHalfRight = SKAction.move(by: CGVector(dx: 30, dy: 0), duration: 0.25)
    
    private var commandShiftUp = SKAction.moveBy(x: 0, y: 100, duration: 0.2)
    private var commandShiftLeftDown = SKAction.moveBy(x: -180, y: -700, duration: 0.2)
    let wait = SKAction.wait(forDuration: 1)
    
    var isRunning = false
    
    // MARK: Wall Configuration
    
    let stage01 = [[1,1,1,0], [1,1,0,0], [0,1,0,0], [0,1,1,0], [1,0,0,1], [0,0,1,0], [1,0,0,0], [0,0,1,0], [1,1,0,0], [0,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,0,1], [0,0,1,1]]
    let stage02 = [[1,1,0,0], [0,1,0,1], [0,1,1,0], [1,1,1,0], [1,0,0,0], [0,1,1,0], [1,0,0,0], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,1,1], [1,0,1,1]]
    let stage03 = [[1,1,1,0], [1,1,0,0], [0,1,0,1], [0,1,1,0], [1,0,1,0], [1,0,0,0], [0,1,0,0], [0,0,1,0], [1,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,1,0], [1,1,1,1], [1,0,1,1], [1,0,1,1], [1,0,1,1]]
    let stage04 = [[1,1,0,1], [0,1,1,0], [1,1,0,0], [0,1,1,1], [1,1,1,0], [1,0,1,0], [1,0,0,0], [0,1,1,0], [1,0,0,0], [0,0,1,1], [1,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,1,1], [1,0,1,1]]
    
    var currentStage:[[Int]] = []
    var currentStageIndex = 0
    
    // MARK: Done Scene Assets
    
    var doneBg : SKSpriteNode?
    var donePopup : SKSpriteNode?
    var btnStageNext : SKSpriteNode?
    var btnStageMenu : SKSpriteNode?
    var btnStageRestart : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        character = SKSpriteNode(imageNamed: "Boy Char")
        
        lineSeperator = SKShapeNode(rect: CGRect(x: 0, y: 200, width: 400, height: 10))
        
        playButton = SKSpriteNode(imageNamed: "play")
        playButton.name = "run"
        
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.name = "back"
        
        leftTapped = SKSpriteNode(imageNamed: "Left")
        leftTapped.name = "left"
        
        rightTapped = SKSpriteNode(imageNamed: "Right")
        rightTapped.name = "right"
        
        upTapped = SKSpriteNode(imageNamed: "Up")
        upTapped.name = "up"
        
        downTapped = SKSpriteNode(imageNamed: "Down")
        downTapped.name = "down"
        
        doneBg = self.childNode(withName: "//cmd-done-bg") as? SKSpriteNode
        donePopup = self.childNode(withName: "//cmd-done-popup") as? SKSpriteNode
        btnStageNext = self.childNode(withName: "//cmd-stage-next") as? SKSpriteNode
        btnStageMenu = self.childNode(withName: "//cmd-stage-menu") as? SKSpriteNode
        btnStageRestart = self.childNode(withName: "//cmd-stage-restart") as? SKSpriteNode
        
        btnStageMenu?.name = "Menu Button"
        btnStageNext?.name = "Next Button"
        btnStageRestart?.name = "Restart Button"
        
        loadStage()
        addChilds()
        removeDoneScene()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
//        print(location)
        
        if (touchedNode.name == "up"){
            commands.append(.up)
            addCommandNode(.up)
        } else if (touchedNode.name == "down") {
            commands.append(.down)
            addCommandNode(.down)
        } else if (touchedNode.name == "left") {
            commands.append(.left)
            addCommandNode(.left)
        } else if (touchedNode.name == "right") {
            commands.append(.right)
            addCommandNode(.right)
        } else if (touchedNode.name == "Menu Button") {
            
        } else if (touchedNode.name == "Next Button") {
            nextStage()
        } else if (touchedNode.name == "Restart Button") {
            
        }
        else {
            var shiftUp = false
            for (index, commandNode) in commandNodes.enumerated() {
                if touchedNode == commandNode {
                    commandNode.removeFromParent()
                    commandNodes.remove(at: index)
                    commands.remove(at: index)
                    shiftUp = true
                    continue
                }
                if shiftUp == true {
                    commandNode.run(commandShiftUp)
                    if index == 7 {
                        commandNode.run(commandShiftLeftDown)
                    }
                }
            }
            
            if (touchedNode.name == "run"){
                if isRunning == true {
                    return
                }
                isRunning = true
                playButton.run(SKAction.fadeOut(withDuration: 0.5))
                runButtonTapped()
            }
        
            if (touchedNode.name == "back"){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let gameViewController = storyBoard.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
                self.view?.window?.rootViewController!.present(gameViewController, animated: true, completion: nil)
            }
        }
    }
    
    func addCommandNode(_ command: Command) {
        if commandNodes.count >= 14 {
            // Over limit of commands
            return
        }
        
        var imageName = ""
        switch command {
        case .left:
            imageName = "Left"
        case .right:
            imageName = "Right"
        case .up:
            imageName = "Up"
        case .down:
            imageName = "Down"
        }
        
        let commandNode = SKSpriteNode(imageNamed: imageName)
        
        let horizontalOffset = (commandNodes.count >= 7) ? 180 : 0
        let verticalOffset = (commandNodes.count >= 7) ? 700 : 0
        
        let x = 85 + horizontalOffset
        let y = 875 - (commandNodes.count * 100) + verticalOffset
        
        commandNode.position = CGPoint(x: x, y: y)
        commandNode.size = commandNodeSize
        addChild(commandNode)
        commandNodes.append(commandNode)
    }
    
    func runButtonTapped() {
        
        var commandSequence: [SKAction] = []
        
        commandSequence.append(moveHome)
        
        for command in commands {
            switch (command) {
            case .left:
                let canGoLeft = currentStage[currentPosition][0]
                if canGoLeft == 1 {
                    commandSequence.append(moveHalfLeft)
                    commandSequence.append(moveHalfRight)
                } else if canGoLeft == 0 {
                    commandSequence.append(moveLeft)
                    currentPosition -= 1
                }
                commandSequence.append(wait)
            case .right:
                let canGoRight = currentStage[currentPosition][2]
                if canGoRight == 1 {
                    commandSequence.append(moveHalfRight)
                    commandSequence.append(moveHalfLeft)
                } else if canGoRight == 0 {
                    commandSequence.append(moveRight)
                    currentPosition += 1
                }
                commandSequence.append(wait)
            case .up:
                let canGoUp = currentStage[currentPosition][1]
                if canGoUp == 1 {
                    commandSequence.append(moveHalfUp)
                    commandSequence.append(moveHalfDown)
                } else if canGoUp == 0 {
                    commandSequence.append(moveUp)
                    currentPosition -= 4
                }
                commandSequence.append(wait)
            case .down:
                let canGoDown = currentStage[currentPosition][3]
                if canGoDown == 1 {
                    commandSequence.append(moveHalfDown)
                    commandSequence.append(moveHalfUp)
                } else if canGoDown == 0 {
                    commandSequence.append(moveDown)
                    currentPosition += 4
                }
                commandSequence.append(wait)
            }
            if currentPosition == 15 {
                let doneAction = SKAction.run {
                    self.doneScene()
                }
                commandSequence.append(doneAction)
                
            }
        }
        character.run(SKAction.sequence(commandSequence), completion: {
            self.isRunning = false
            self.playButton.run(SKAction.fadeIn(withDuration: 0.5))
            self.currentPosition = 0
        })
    }
    
    func loadStage() {
        character.position = characterLocation
        character.size = CGSize(width: 150, height: 150)
        
        lineSeperator.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        playButton.position = CGPoint(x: 890, y: 100)
        playButton.size = CGSize(width: 100, height: 100)
        
        backButton.position = CGPoint(x: 50, y: 970)
        backButton.size = CGSize(width: 50, height: 50)
        
        leftTapped.position = CGPoint(x: 50, y: 100)
        leftTapped.size = CGSize(width: 75, height: 75)
        
        rightTapped.position = CGPoint(x: 150, y: 100)
        rightTapped.size = CGSize(width: 75, height: 75)
        
        upTapped.position = CGPoint(x: 250, y: 100)
        upTapped.size = CGSize(width: 75, height: 75)
        
        downTapped.position = CGPoint(x: 350, y: 100)
        downTapped.size = CGSize(width: 75, height: 75)
        
        if currentStageIndex == 0 {
            currentStage = stage01
        }
        if currentStageIndex == 1 {
            currentStage = stage02
        }
        if currentStageIndex == 2 {
            currentStage = stage03
        }
        if currentStageIndex == 3 {
            currentStage = stage04
        }
        
        print(currentStageIndex)
//        currentStageIndex += 1
    }
    
    func doneScene() {
        addChild(doneBg!)
    }
    
    func removeDoneScene() {
        doneBg?.removeFromParent()
    }
    
    func addChilds() {
        addChild(character)
        addChild(lineSeperator)
        addChild(playButton)
        addChild(backButton)
        addChild(rightTapped)
        addChild(leftTapped)
        addChild(upTapped)
        addChild(downTapped)
    }
    
    func nextStage() {
        let spawn = SKAction.run {
            self.removeAllChildren()
            self.removeFromParent()
        }
        let changeScene = SKAction.run {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let scene = MazeStage(fileNamed: "MazeStage2")
            scene?.scaleMode = .aspectFill
            scene?.currentStageIndex = self.currentStageIndex + 1
            self.scene?.view?.presentScene(scene!, transition: transition)
        }
        let loadScene = SKAction.run {
            self.loadStage()
            self.addChilds()
            self.removeDoneScene()
        }
        currentStage = stage02
        let sequence = SKAction.sequence([spawn, changeScene, loadScene])
        run(sequence)
    }
}

