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
    
    var backgroundScene = SKShapeNode()
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
    
    let stage01 = [[1,1,1,0], [1,1,0,0], [0,1,0,0], [0,1,1,0], [1,0,0,1], [0,0,1,0], [1,0,0,0], [0,0,1,0], [1,1,0,0], [0,0,1,0], [1,0,1,0], [1,0,1,0], [1,0,0,1], [0,0,0,1], [0,0,0,1], [0,0,1,1]]
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        character = SKSpriteNode(imageNamed: "monster")
        character.position = CGPoint(x: 550, y: 840)
        character.size = CGSize(width: 150, height: 150)
        
        backgroundScene = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 400, height: 1024))
        backgroundScene.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        lineSeperator = SKShapeNode(rect: CGRect(x: 0, y: 200, width: 400, height: 10))
        lineSeperator.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        playButton = SKSpriteNode(imageNamed: "run-tapped")
        playButton.position = CGPoint(x: 900, y: 100)
        playButton.name = "run"
        playButton.size = CGSize(width: 100, height: 100)
        
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.name = "back"
        backButton.position = CGPoint(x: 50, y: 970)
        backButton.size = CGSize(width: 50, height: 50)
        
        leftTapped = SKSpriteNode(imageNamed: "left-tapped")
        leftTapped.name = "left"
        leftTapped.position = CGPoint(x: 50, y: 100)
        leftTapped.size = CGSize(width: 75, height: 75)
        
        rightTapped = SKSpriteNode(imageNamed: "right-tapped")
        rightTapped.name = "right"
        rightTapped.position = CGPoint(x: 150, y: 100)
        rightTapped.size = CGSize(width: 75, height: 75)
        
        upTapped = SKSpriteNode(imageNamed: "up-tapped")
        upTapped.name = "up"
        upTapped.position = CGPoint(x: 250, y: 100)
        upTapped.size = CGSize(width: 75, height: 75)
        
        downTapped = SKSpriteNode(imageNamed: "down-tapped")
        downTapped.name = "down"
        downTapped.position = CGPoint(x: 350, y: 100)
        downTapped.size = CGSize(width: 75, height: 75)
        
        
//        wall1 = childNode(withName: "wall1") as! SKSpriteNode
//        wall2 = childNode(withName: "wall2") as! SKSpriteNode
//        wall3 = childNode(withName: "wall3") as! SKSpriteNode
//        wall4 = childNode(withName: "wall4") as! SKSpriteNode
//        wall5 = childNode(withName: "wall5") as! SKSpriteNode
//        wall6 = childNode(withName: "wall6") as! SKSpriteNode
        
        
        addChilds()
//        buildWall()
        
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
            imageName = "left-tapped"
        case .right:
            imageName = "right-tapped"
        case .up:
            imageName = "up-tapped"
        case .down:
            imageName = "down-tapped"
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
                let canGoLeft = stage01[currentPosition][0]
                if canGoLeft == 1 {
                    commandSequence.append(moveHalfLeft)
                    commandSequence.append(moveHalfRight)
                } else if canGoLeft == 0 {
                commandSequence.append(moveLeft)
                currentPosition -= 1
                }
                commandSequence.append(wait)
            case .right:
                let canGoRight = stage01[currentPosition][2]
                if canGoRight == 1 {
                    commandSequence.append(moveHalfRight)
                    commandSequence.append(moveHalfLeft)
                } else if canGoRight == 0 {
                    commandSequence.append(moveRight)
                    currentPosition += 1
                }
                commandSequence.append(wait)
            case .up:
                let canGoUp = stage01[currentPosition][1]
                if canGoUp == 1 {
                    commandSequence.append(moveHalfUp)
                    commandSequence.append(moveHalfDown)
                } else if canGoUp == 0 {
                    commandSequence.append(moveUp)
                    currentPosition -= 4
                }
                commandSequence.append(wait)
            case .down:
                let canGoDown = stage01[currentPosition][3]
                if canGoDown == 1 {
                    commandSequence.append(moveHalfDown)
                    commandSequence.append(moveHalfUp)
                } else if canGoDown == 0 {
                    commandSequence.append(moveDown)
                    currentPosition += 4
                }
                commandSequence.append(wait)
            }
        }
        character.run(SKAction.sequence(commandSequence))
    }
    
//    func buildWall() {
//        for (index, wall) in stage01.enumerated() {
//
//            let horizontalSize = CGSize(width: 20, height: 220)
//            let verticalSize = CGSize(width: 220, height: 20)
//
//
//            if index % 4 == 0 && index > 0 {
//                y -= 220
//            }
//
//            if wall[0] == 1 {
//                let newWall = SKSpriteNode(imageNamed: "horizontal-wall")
//                newWall.position = CGPoint(x: x - 110, y: y)
//                newWall.zPosition = 5
//                newWall.size = horizontalSize
//                addChild(newWall)
//                print(newWall.position)
//            }
//            if wall[1] == 1 {
//                let newWall = SKSpriteNode(imageNamed: "vertical-wall")
//                newWall.position = CGPoint(x: x, y: y + 110)
//                newWall.zPosition = 5
//                newWall.size = verticalSize
//                addChild(newWall)
//                print(newWall.position)
//            }
//            if wall[2] == 1 {
//                let newWall = SKSpriteNode(imageNamed: "horizontal-wall")
//                newWall.position = CGPoint(x: x + 110, y: y)
//                newWall.zPosition = 5
//                newWall.size = horizontalSize
//                addChild(newWall)
//                print(newWall.position)
//            }
//            if wall[3] == 1 {
//                let newWall = SKSpriteNode(imageNamed: "vertical-wall")
//                newWall.position = CGPoint(x: x, y: y - 110)
//                newWall.zPosition = 5
//                newWall.size = verticalSize
//                addChild(newWall)
//                print(newWall.position)
//            }
//        }
//    }
    
    func addChilds() {
        addChild(character)
        addChild(backgroundScene)
        addChild(lineSeperator)
        addChild(playButton)
        addChild(backButton)
        addChild(rightTapped)
        addChild(leftTapped)
        addChild(upTapped)
        addChild(downTapped)
    }
    
    
}

