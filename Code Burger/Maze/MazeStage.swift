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
    
    var character = SKSpriteNode()
    
    var playButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    var leftTapped = SKSpriteNode()
    var rightTapped = SKSpriteNode()
    var upTapped = SKSpriteNode()
    var downTapped = SKSpriteNode()
    var lineSeperator = SKShapeNode()
    
    var wall1 = SKSpriteNode()
    var wall2 = SKSpriteNode()
    var wall3 = SKSpriteNode()
    var wall4 = SKSpriteNode()
    var wall5 = SKSpriteNode()
    var wall6 = SKSpriteNode()
    var tiles = SKSpriteNode()
    var outerFrame = SKSpriteNode()
    
    var currentPosition = 0
    
    var commandLocation = CGPoint(x: 50, y: 900)
    var characterLocation = CGPoint(x: 550, y: 840)
    var commandNodeSize = CGSize(width: 75, height: 75)
    
    var commands: [Command] = []
    var wallPlacements: [WallPlacement] = []
    var commandNodes: [SKSpriteNode] = []
    
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
    
    let stage01 = [[1,1,1,0], [1,1,0,0], [0,1,0,0], [0,1,1,0], [1,0,0,1], [0,0,1,0], [1,0,0,0], [0,0,1,0], [1,1,0,0], [0,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,0,1], [0,0,1,1]]
    let stage02 = [[1,1,0,0], [0,1,0,1], [0,1,1,0], [1,1,1,0], [1,0,0,0], [0,1,1,0], [1,0,0,0], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,1,1], [1,0,1,1]]
    let stage03 = [[1,1,1,0], [1,1,0,0], [0,1,0,1], [0,1,1,0], [1,0,1,0], [1,0,0,0], [0,1,0,0], [0,0,1,0], [1,0,0,1], [0,0,1,0], [1,0,1,0], [1,0,1,0], [1,1,1,1], [1,0,1,1], [1,0,1,1], [1,0,1,1]]
    let stage04 = [[1,1,0,1], [0,1,1,0], [1,1,0,0], [0,1,1,1], [1,1,1,0], [1,0,1,0], [1,0,0,0], [0,1,1,0], [1,0,0,0], [0,0,1,1], [1,0,1,0], [1,0,1,0], [1,0,0,1], [0,1,0,1], [0,0,1,1], [1,0,1,1]]
    
    var currentStage:[[Int]] = []
    
    override func didMove(to view: SKView) {
        
        currentStage = stage01
        
        character = SKSpriteNode(imageNamed: "Boy Char")
        character.position = characterLocation
        character.size = CGSize(width: 150, height: 150)
        
        lineSeperator = SKShapeNode(rect: CGRect(x: 0, y: 200, width: 400, height: 10))
        lineSeperator.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 890, y: 100)
        playButton.name = "run"
        playButton.size = CGSize(width: 100, height: 100)
        
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.name = "back"
        backButton.position = CGPoint(x: 50, y: 970)
        backButton.size = CGSize(width: 50, height: 50)
        
        leftTapped = SKSpriteNode(imageNamed: "Left")
        leftTapped.name = "left"
        leftTapped.position = CGPoint(x: 50, y: 100)
        leftTapped.size = CGSize(width: 75, height: 75)
        
        rightTapped = SKSpriteNode(imageNamed: "Right")
        rightTapped.name = "right"
        rightTapped.position = CGPoint(x: 150, y: 100)
        rightTapped.size = CGSize(width: 75, height: 75)
        
        upTapped = SKSpriteNode(imageNamed: "Up")
        upTapped.name = "up"
        upTapped.position = CGPoint(x: 250, y: 100)
        upTapped.size = CGSize(width: 75, height: 75)
        
        downTapped = SKSpriteNode(imageNamed: "Down")
        downTapped.name = "down"
        downTapped.position = CGPoint(x: 350, y: 100)
        downTapped.size = CGSize(width: 75, height: 75)
        
        addChilds()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
        print(location)
        
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
        } else {
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
                print("DiCKToll")
            }
            
//            if commandLocation.y == 200 {
//                commandLocation.x += 100
//                commandLocation.y = 900
//            }
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
    
    //    func removeCommandNodes() {
    //        for commandNode in commandNodes {
    //            commandNode.removeFromParent()
    //        }
    //    }
    
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
                
                let finishedBackground = SKSpriteNode(imageNamed: "Victory Scene")
                finishedBackground.position = CGPoint(x: 682, y: 600)
                finishedBackground.zPosition = 15
                
                let scaleOut = SKAction.scale(to: 1.5, duration: 0.01)
                
                let addFinishedScene = SKAction.run {
                    self.addChild(finishedBackground)
                    finishedBackground.run(scaleOut)
                }
                commandSequence.append(addFinishedScene)
            }
        }
        character.run(SKAction.sequence(commandSequence), completion: {
            self.isRunning = false
            self.playButton.run(SKAction.fadeIn(withDuration: 0.5))
            self.currentPosition = 0
        })
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
}

