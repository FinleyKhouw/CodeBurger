//
//  CommandGameScene.swift
//  CodeBurger
//
//  Created by William Sjahrial on 2019/07/11.
//  Copyright © 2019 William Sjahrial. All rights reserved.
//

import SpriteKit
import GameplayKit

enum Command {
    case left
    case right
    case down
}

class CommandGameScene: SKScene {
    
    // Objects
    
    private var catcher : SKSpriteNode?
    private var burger: SKSpriteNode?
    
    // Buttons
    
    private var btnBack : SKSpriteNode?
    private var btnLeft : SKSpriteNode?
    private var btnRight : SKSpriteNode?
    private var btnDown : SKSpriteNode?
    private var btnGo : SKSpriteNode?
    private var btnClear : SKSpriteNode?
    
    // Actions
    
    private var actionLeft = SKAction.moveBy(x: -90, y: 0, duration: 0.2)
    private var actionRight = SKAction.moveBy(x: 90, y: 0, duration: 0.2)
    private var actionDown = SKAction.moveBy(x: 0, y: -200, duration: 0.2)
    private var actionUp = SKAction.moveBy(x: 0, y: 200, duration: 0.2)
    private var actionHome = SKAction.move(to: CGPoint(x: 480, y: 600), duration: 1.0)
    private var actionTarget = SKAction.move(to: CGPoint(x: 930, y: 600), duration: 1.0)
    private var actionLeftHalf = SKAction.moveBy(x: -30, y: 0, duration: 0.1)
    private var actionRightHalf = SKAction.moveBy(x: 30, y: 0, duration: 0.1)
    private var wait = SKAction.wait(forDuration: 0.5)
    private var commandShiftUp = SKAction.moveBy(x: 0, y: 50, duration: 0.2)
    private var commandShiftLeftDown = SKAction.moveBy(x: -180, y: -500, duration: 0.2)
    
    // Sounds
    
    private var soundMove = SKAction.playSoundFileNamed("Clank.mp3", waitForCompletion: false)
    private var soundCatch = SKAction.playSoundFileNamed("Hydraulics Engaged.caf", waitForCompletion: false)
    private var soundGo = SKAction.playSoundFileNamed("Computer Data 03.caf", waitForCompletion: false)
    
    // Animations
    
    private var textureCatcher = SKTexture(imageNamed: "catcher")
    
    private var animatePickUp = SKAction.animate(with: [SKTexture(imageNamed: "catcher-0"),
                                                        SKTexture(imageNamed: "catcher-1"),
                                                        SKTexture(imageNamed: "catcher-2")],
                                                 timePerFrame: 0.2)
    
    private var animateDropOff = SKAction.animate(with: [SKTexture(imageNamed: "catcher-2"),
                                                         SKTexture(imageNamed: "catcher-1"),
                                                         SKTexture(imageNamed: "catcher-0")],
                                                  timePerFrame: 0.2)
    
    // Commands
    
    private var commands: [Command] = []
    private var commandNodes: [SKSpriteNode] = []
    
    let burgerPosition = 2
    let targetPosition = 5
    
    var isGoing = false
    var isBurgerAcquired = false
    var isBurgerDelivered = false
    
    override func didMove(to view: SKView) {
        
        self.catcher = self.childNode(withName: "//catcher") as? SKSpriteNode
        self.burger = self.childNode(withName: "//burger") as? SKSpriteNode
        
        self.btnBack = self.childNode(withName: "//btn-back") as? SKSpriteNode
        self.btnLeft = self.childNode(withName: "//btn-left") as? SKSpriteNode
        self.btnRight = self.childNode(withName: "//btn-right") as? SKSpriteNode
        self.btnDown = self.childNode(withName: "//btn-down") as? SKSpriteNode
        self.btnGo = self.childNode(withName: "//btn-go") as? SKSpriteNode
        self.btnClear = self.childNode(withName: "//btn-clear") as? SKSpriteNode
        
    }
    
    // MARK: - Handle Touches
    
    func touchDown(atPoint pos : CGPoint) {
        print(#function)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print(#function)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print(#function)
        let node = self.nodes(at: pos).first
        if node == self.btnLeft {
            print("btnLeft")
            commands.append(.left)
            addCommandNode(.left)
        } else if node == self.btnRight {
            print("btnRight")
            commands.append(.right)
            addCommandNode(.right)
        } else if node == self.btnDown {
            print("btnDown")
            commands.append(.down)
            addCommandNode(.down)
        } else if node == self.btnGo {
            print("btnGo")
            self.btnGo?.run(soundGo)
            go()
        } else if node == self.btnClear {
            print("btnClear")
            clearAll()
        } else {
            // tap command nodes to remove
            var shiftUp = false
            for (index, commandNode) in commandNodes.enumerated() {
                if node == commandNode {
                    commandNode.removeFromParent()
                    commandNodes.remove(at: index)
                    commands.remove(at: index)
                    shiftUp = true
                    continue
                }
                if shiftUp == true {
                    commandNode.run(commandShiftUp)
                    if index == 10 {
                        commandNode.run(commandShiftLeftDown)
                    }
                }
            }
        }
    }
    
    func addCommandNode(_ command: Command) {
        print(#function)
        
        if commandNodes.count >= 20 {
            // over limit
            return
        }
        
        var imageName = ""
        switch command {
        case .left:
            imageName = "cmd-left"
        case .right:
            imageName = "cmd-right"
        case .down:
            imageName = "cmd-down"
        }
        let commandNode = SKSpriteNode(imageNamed: imageName)
        
        let horizontalOffset = (commandNodes.count >= 10) ? 180 : 0
        let verticalOffset = (commandNodes.count >= 10) ? 500 : 0
        
        let x = 100 + horizontalOffset
        let y = 650 - (commandNodes.count * 50) + verticalOffset
        
        commandNode.position = CGPoint(x: x, y: y)
        commandNode.zPosition = 4
        addChild(commandNode)
        commandNodes.append(commandNode)
    }
    
    func removeCommandNodes() {
        print(#function)
        for commandNode in commandNodes {
            commandNode.removeFromParent()
        }
        commandNodes.removeAll()
    }
    
    func clear() {
        commandNodes.removeAll()
        commands.removeAll()
    }
        
    func go() {
        
        if isGoing == true {
            return
        }
        isGoing = true
        
        var catcherPosition = 0
        
        var actions: [SKAction] = []
        actions.append(actionHome)
        for command in commands {
            print("catcher position: \(catcherPosition)")
            switch(command) {
            case .left:
                actions.append(soundMove)
                let canGoLeft = catcherPosition > 0
                if canGoLeft == false {
                    actions.append(actionLeftHalf)
                    actions.append(actionRightHalf)
                } else {
                    actions.append(actionLeft)
                    catcherPosition -= 1
                }
                actions.append(wait)
            case .right:
                actions.append(soundMove)
                let canGoRight = catcherPosition < targetPosition
                if canGoRight == false {
                    actions.append(actionRightHalf)
                    actions.append(actionLeftHalf)
                } else {
                    actions.append(actionRight)
                    catcherPosition += 1
                }
                actions.append(wait)
            case .down:
                actions.append(soundCatch)
                actions.append(actionDown)
                actions.append(wait)
                if catcherPosition == burgerPosition && isBurgerAcquired == false {
                    actions.append(animatePickUp)
                    let pickupAction = SKAction.customAction(withDuration: 0.5) { (node, elapsedTime) in
                        self.burger?.removeFromParent()
                        self.burger = SKSpriteNode(imageNamed: "burger")
                        self.burger?.position = CGPoint(x:0, y:-20)
                        self.catcher?.addChild(self.burger!)
                    }
                    actions.append(pickupAction)
                    isBurgerAcquired = true
                } else if catcherPosition == targetPosition && isBurgerAcquired == true {
                    actions.append(animateDropOff)
                    let dropOffAction = SKAction.customAction(withDuration: 0.5) { (node, elapsedTime) in
                        self.burger?.removeFromParent()
                        self.burger = SKSpriteNode(imageNamed: "burger")
                        self.burger?.position = CGPoint(x:930, y:360)
                        self.burger?.zPosition = 4
                        self.addChild(self.burger!)
                    }
                    actions.append(dropOffAction)
                    isBurgerDelivered = true
                }
                actions.append(actionUp)
                actions.append(wait)
                
            }
        }
        catcher?.run(SKAction.sequence(actions), completion: {
            // Go Home
            self.catcher?.run(self.actionHome, completion: {
                self.isGoing = false
                self.isBurgerAcquired = false
                self.isBurgerDelivered = false
                // Reset Catcher
                self.catcher?.texture = self.textureCatcher
                // Reset Burger
                self.burger?.removeFromParent()
                self.burger = SKSpriteNode(imageNamed: "burger")
                self.burger?.position = CGPoint(x:660, y:360)
                self.burger?.zPosition = 4
                self.addChild(self.burger!)
            })
        })
    }
    
    func clearAll() {
        commands.removeAll()
        removeCommandNodes()
        catcher?.run(actionHome)
    }
    
    // MARK: - Touch Listener
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // MARK: - Update
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

