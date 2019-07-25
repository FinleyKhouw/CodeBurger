//
//  CommandGameScene.swift
//  CodeBurger
//
//  Created by William Sjahrial on 2019/07/11.
//  Copyright © 2019 William Sjahrial. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CraneCommand {
    case left
    case right
    case down
}

struct CommandStage {
    var stageNum = 0
    var home = CGPoint.zero
    var numBars = 3
    var barDistance = 100
    var burgerPosition = 2
    var targetPosition = 3
}

// Stage Data

let stage4 = CommandStage(stageNum: 4,
                          home: CGPoint(x:570, y:600),
                          numBars: 3,
                          barDistance: 130,
                          burgerPosition: 1,
                          targetPosition: 2)

let stage5 = CommandStage(stageNum: 5,
                          home: CGPoint(x:520, y:600),
                          numBars: 4,
                          barDistance: 110,
                          burgerPosition: 0,
                          targetPosition: 3)

let stage6 = CommandStage(stageNum: 6,
                          home: CGPoint(x:500, y:600),
                          numBars: 5,
                          barDistance: 110,
                          burgerPosition: 1,
                          targetPosition: 4)

let stage7 = CommandStage(stageNum: 7,
                          home: CGPoint(x:500, y:600),
                          numBars: 5,
                          barDistance: 110,
                          burgerPosition: 2,
                          targetPosition: 4)

protocol GameManager {
    
    func backToStageSelect()
    
}

class CommandGameScene: SKScene {
    
    var stageIndex = 3 // 3 - 6
    private var currStage = stage4
    
    var gameManager: GameManager?
    
    // Objects
    
    private var stage : SKSpriteNode?
    private var catcher : SKSpriteNode?
    private var burger: SKSpriteNode?
    
    // Popups
    
    private var doneBg : SKSpriteNode?
    private var donePopup : SKSpriteNode?
    private var btnStageNext : SKSpriteNode?
    private var btnStageMenu : SKSpriteNode?
    private var btnStageRestart : SKSpriteNode?
    
    // Buttons
    
    private var btnBack : SKSpriteNode?
    private var btnLeft : SKSpriteNode?
    private var btnRight : SKSpriteNode?
    private var btnDown : SKSpriteNode?
    private var btnGo : SKSpriteNode?
    private var btnClear : SKSpriteNode?
    
    // Actions
    
    private var actionLeft = SKAction.moveBy(x: -100, y: 0, duration: 0.2)
    private var actionRight = SKAction.moveBy(x: 100, y: 0, duration: 0.2)
    private var actionDown = SKAction.moveBy(x: 0, y: -200, duration: 0.2)
    private var actionUp = SKAction.moveBy(x: 0, y: 200, duration: 0.2)
    private var actionHome = SKAction.move(to: CGPoint(x:500, y:600), duration: 1.0)
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
    
    private var commands: [CraneCommand] = []
    private var commandNodes: [SKSpriteNode] = []
    
    var isGoing = false
    var isBurgerAcquired = false
    var isBurgerDelivered = false
    
    override func didMove(to view: SKView) {
        
        self.stage = self.childNode(withName: "//cmd-stage") as? SKSpriteNode
        
        self.catcher = self.childNode(withName: "//catcher") as? SKSpriteNode
        self.catcher?.zPosition = 3
        
        self.burger = self.childNode(withName: "//cmd-burger") as? SKSpriteNode
        self.burger?.zPosition = 4
        
        self.btnBack = self.childNode(withName: "//btn-back") as? SKSpriteNode
        self.btnLeft = self.childNode(withName: "//btn-left") as? SKSpriteNode
        self.btnRight = self.childNode(withName: "//btn-right") as? SKSpriteNode
        self.btnDown = self.childNode(withName: "//btn-down") as? SKSpriteNode
        self.btnGo = self.childNode(withName: "//btn-go") as? SKSpriteNode
        self.btnClear = self.childNode(withName: "//btn-clear") as? SKSpriteNode
     
        self.doneBg = self.childNode(withName: "//cmd-done-bg") as? SKSpriteNode
        self.donePopup = self.childNode(withName: "//cmd-done-popup") as? SKSpriteNode
        self.btnStageNext = self.childNode(withName: "//cmd-stage-next") as? SKSpriteNode
        self.btnStageMenu = self.childNode(withName: "//cmd-stage-menu") as? SKSpriteNode
        self.btnStageRestart = self.childNode(withName: "//cmd-stage-restart") as? SKSpriteNode
        
        loadStage()
        
        hideDonePopup()
        
    }
    
    func loadStage() {
        
        if stageIndex == 3 {
            self.currStage = stage4
        } else if stageIndex == 4 {
            self.currStage = stage5
        } else if stageIndex == 5 {
            self.currStage = stage6
        } else if stageIndex == 6 {
            self.currStage = stage7
        } else {
            print("invalid stageIndex")
        }
        
        self.stage?.texture = SKTexture(imageNamed: "cmd-stage-\(self.currStage.numBars)")
        self.catcher?.position = self.currStage.home
        self.catcher?.zPosition = 3
        
        self.actionHome = SKAction.move(to: self.currStage.home, duration: 1.0)
        
        let x = Int(self.currStage.home.x) + self.currStage.burgerPosition*self.currStage.barDistance
        self.burger?.position = CGPoint(x:x, y:360)
        self.burger?.zPosition = 4

        self.actionLeft = SKAction.moveBy(x: 0-CGFloat(self.currStage.barDistance), y: 0, duration: 0.2)
        self.actionRight = SKAction.moveBy(x: CGFloat(self.currStage.barDistance), y: 0, duration: 0.2)
        
        self.commands.removeAll()
        self.removeCommandNodes()
        self.catcher?.removeAllActions()
        
        self.isGoing = false
        self.isBurgerAcquired = false
        self.isBurgerDelivered = false
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
        } else if node == self.btnStageNext {
            print("btnStageNext")
            if currStage.stageNum == 4 {
                currStage = stage5
                loadStage()
                hideDonePopup()
            } else if currStage.stageNum == 5 {
                currStage = stage6
                loadStage()
                hideDonePopup()
            } else if currStage.stageNum == 6 {                
                currStage = stage7
                loadStage()
                hideDonePopup()
            } else if currStage.stageNum == 7 {
                changeSceneMaze()
            }
        } else if node == self.btnStageMenu {
            print("btnStageMenu")
            // go to menu
            backToStageSelect()
        } else if node == self.btnStageRestart {
            print("btnStageRestart")
            loadStage()
            hideDonePopup()
        } else if node == self.btnBack {
            print("btnBack")
            // go to menu
            backToStageSelect()
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
    
    func addCommandNode(_ command: CraneCommand) {
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
                let canGoRight = catcherPosition < self.currStage.numBars-1
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
                if catcherPosition == self.currStage.burgerPosition && isBurgerAcquired == false {
                    actions.append(animatePickUp)
                    let pickupAction = SKAction.customAction(withDuration: 0.5) { (node, elapsedTime) in
                        self.burger?.removeFromParent()
                        self.burger = SKSpriteNode(imageNamed: "cmd-burger")
                        self.burger?.position = CGPoint(x:0, y:-20)
                        self.burger?.zPosition = 4
                        self.catcher?.addChild(self.burger!)
                    }
                    actions.append(pickupAction)
                    isBurgerAcquired = true
                } else if catcherPosition == self.currStage.targetPosition && isBurgerAcquired == true {
                    actions.append(animateDropOff)
                    let dropOffAction = SKAction.customAction(withDuration: 0.5) { (node, elapsedTime) in
                        self.burger?.removeFromParent()
                        self.burger = SKSpriteNode(imageNamed: "cmd-burger")
                        let x = Int(self.currStage.home.x) + self.currStage.targetPosition*self.currStage.barDistance
                        self.burger?.position = CGPoint(x:x, y:360)
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
            if self.isBurgerDelivered {
                // Success! Show Done Popup
                self.isGoing = false
                self.isBurgerAcquired = false
                self.isBurgerDelivered = false
                self.showDonePopup()
            } else {
                // Fail! Go Home
                self.catcher?.run(self.actionHome, completion: {
                    self.isGoing = false
                    self.isBurgerAcquired = false
                    self.isBurgerDelivered = false
                    // Reset Catcher
                    self.catcher?.texture = self.textureCatcher
                    // Reset Burger
                    self.burger?.removeFromParent()
                    self.burger = SKSpriteNode(imageNamed: "cmd-burger")
                    let x = Int(self.currStage.home.x) + self.currStage.burgerPosition*self.currStage.barDistance
                    self.burger?.position = CGPoint(x:x, y:360)
                    self.burger?.zPosition = 4
                    self.addChild(self.burger!)
                })
            }
        })
    }
    
    func clearAll() {
        commands.removeAll()
        removeCommandNodes()
        catcher?.removeAllActions()
        // Go Home
        self.catcher?.run(self.actionHome, completion: {
            self.isGoing = false
            self.isBurgerAcquired = false
            self.isBurgerDelivered = false
            // Reset Catcher
            self.catcher?.texture = self.textureCatcher
            // Reset Burger
            self.burger?.removeFromParent()
            self.burger = SKSpriteNode(imageNamed: "cmd-burger")
            let x = Int(self.currStage.home.x) + self.currStage.burgerPosition*self.currStage.barDistance
            self.burger?.position = CGPoint(x:x, y:360)
            self.burger?.zPosition = 4
            self.addChild(self.burger!)
        })
    }
    
    // MARK: - Done Popup
    
    func hideDonePopup() {
        print(#function)
        doneBg?.removeFromParent()
    }
    
    func showDonePopup() {
        print(#function)
        addChild(doneBg!)
        doneBg?.zPosition = 5
    }
    
    func backToStageSelect() {
        print(#function)
        
        gameManager?.backToStageSelect()
    }
    
    func changeSceneMaze() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sequenceController = storyBoard.instantiateViewController(withIdentifier:
            "mazeStage")
        self.view?.window?.rootViewController!.present(sequenceController, animated: true, completion: nil)
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

