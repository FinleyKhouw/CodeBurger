//
//  SequenceStageOne.swift
//  Code Burger
//
//  Created by Mirza Fachreza 2 on 18/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit

var doneBg : SKSpriteNode?
var donePopup : SKSpriteNode?
var btnStageNext : SKSpriteNode?
var btnStageMenu : SKSpriteNode?
var btnStageRestart : SKSpriteNode?
var backBtn: SKSpriteNode!

class SequenceStageOne: SKScene {
    
    var boundary: SKSpriteNode!
    var piringDua: SKSpriteNode!
    var satuSedang: SKSpriteNode!
    var duaSedang: SKSpriteNode!
    var tigaSedang: SKSpriteNode!
    var meja: SKSpriteNode!
    var untouchableSedang =  CGRect(x: 580, y: 50, width: 250, height: 250)
    let targetSedang = CGRect(x: 580, y: 50, width: 250, height: 250)
    var pointSedang = CGPoint(x: 642, y: 160)
    let initialSedang = CGPoint(x: 648, y: 510)
    var intKotak = 0
    var fase = 1
    private var currentNode: SKNode?
    var userDef = UserDefaults.standard
    
    func hideFase(){
        duaSedang.isHidden = true
        tigaSedang.isHidden = true
    }
    
    func checkLogic(){
        if intKotak == 1{
            print("Mantap")
            if fase == 1{
                fase += 1
                
                pointSedang = CGPoint(x: 642, y: 190)
                duaSedang.isHidden = false
                
                intKotak = 0
            } else if fase == 2{
                fase += 1
                pointSedang = CGPoint(x: 642, y: 240)
                tigaSedang.isHidden = false
                intKotak = 0
            } else if fase == 3{
                SKAction.wait(forDuration: 2)
                showDonePopup()
                
            }
        }
    }
    
    func hideDonePopup() {
        print(#function)
        doneBg?.removeFromParent()
    }
    
    func showDonePopup() {
        SKAction.wait(forDuration: 1)
        print(#function)
        addChild(doneBg!)
        doneBg?.zPosition = 5
    }
    
    func restart(){
        intKotak = 0
        hideFase()
        
        satuSedang.run(SKAction.move(to: initialSedang, duration: 0.1))
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        backBtn = self.childNode(withName: "backBtn") as? SKSpriteNode
        doneBg = self.childNode(withName: "//cmd-done-bg") as? SKSpriteNode
        donePopup = self.childNode(withName: "//cmd-done-popup") as? SKSpriteNode
        btnStageNext = self.childNode(withName: "//cmd-stage-next") as? SKSpriteNode
        btnStageMenu = self.childNode(withName: "//cmd-stage-menu") as? SKSpriteNode
        btnStageRestart = self.childNode(withName: "//cmd-stage-restart") as? SKSpriteNode
        boundary = self.childNode(withName: "boundary") as? SKSpriteNode
        satuSedang = self.childNode(withName: "satuSedang") as? SKSpriteNode
        duaSedang = self.childNode(withName: "duaSedang") as? SKSpriteNode
        tigaSedang = self.childNode(withName: "tigaSedang") as? SKSpriteNode
        meja = self.childNode(withName: "meja") as? SKSpriteNode
        backBtn.zPosition = 5
        meja.zPosition = -1
        boundary.zPosition = -1
        
        hideFase()
        hideDonePopup()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            
            guard !untouchableSedang.contains(location) else {
                return
            }
            
            for node in touchedNodes.reversed(){
                if fase == 1{
                    if (node.name?.contains("satu"))!{
                        self.currentNode = node
                    }
                    
                } else if fase == 2{
                    if (node.name?.contains("dua"))!{
                        self.currentNode = node
                    }
                } else if fase == 3{
                    if (node.name?.contains("tiga"))!{
                        self.currentNode = node
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
            let touch: UITouch = touches.first as! UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if (touchedNode == btnStageNext){
                guard let scene = SequenceStageTwo(fileNamed: "SequenceStageTwo") else { return }
                self.scene?.view?.presentScene(scene)
            } else if (touchedNode == btnStageRestart){
                hideDonePopup()
                restart()
            } else if touchedNode == btnStageMenu{
                guard let scene = StageSelect(fileNamed: "StageSelect") else { return }
                self.scene?.view?.presentScene(scene)
            } else if touchedNode == backBtn{
                guard let scene = StageSelect(fileNamed: "StageSelect") else { return }
                self.scene?.view?.presentScene(scene)
            }
        }
        
        guard let node = self.currentNode else {return}
        
       if targetSedang.contains(node.position){
            if intKotak == 0 && (node.name?.contains("Sedang"))!{
                intKotak = 1
                node.run(SKAction.move(to: pointSedang, duration: 0.1))
                
            }
        }else{
            if (node.name?.contains("Sedang"))!{
                node.run(SKAction.move(to: initialSedang, duration: 0.1))
            }
        }
        
        self.currentNode = nil
        
        checkLogic()
        
    }
    
    
    
}

