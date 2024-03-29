//
//  SequenceStageTwo.swift
//  Code Burger
//
//  Created by Mirza Fachreza 2 on 19/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit
import SpriteKit

class SequenceStageTwo: SKScene {
    
    var gameManager: GameManager?
    
    var boundary: SKSpriteNode!
    var piringSatu: SKSpriteNode!
    var piringDua: SKSpriteNode!
    var piringTiga: SKSpriteNode!
    var satuKecil: SKSpriteNode!
    var satuSedang: SKSpriteNode!
    var satuBesar: SKSpriteNode!
    var duaKecil: SKSpriteNode!
    var duaSedeng: SKSpriteNode!
    var duaBeser: SKSpriteNode!
    var tigaKecol: SKSpriteNode!
    var tigaSedang: SKSpriteNode!
    var tigaBesor: SKSpriteNode!
    var untouchableKecil = CGRect(x: 210, y: 50, width: 250, height: 250)
    var untouchableSedang =  CGRect(x: 580, y: 50, width: 250, height: 250)
    let untouchableBesar = CGRect(x: 909, y: 50, width: 250, height: 250)
    var targetKecil = CGRect(x: 210, y: 50, width: 250, height: 250)
    let targetSedang = CGRect(x: 580, y: 50, width: 250, height: 250)
    let targetBesar = CGRect(x: 909, y: 50, width: 250, height: 250)
    var pointKecil = CGPoint(x: 309, y: 160)
    var pointSedang = CGPoint(x: 642, y: 160)
    var pointBesar = CGPoint(x: 1008, y: 160)
    let initialKecil = CGPoint(x: 405, y: 510)
    let initialSedang = CGPoint(x: 648, y: 510)
    let initialBesar = CGPoint(x: 936, y: 510)
    var arrayKotak = [0,0,0]
    var fase = 1
    var meja: SKSpriteNode!
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        
        
        
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        backBtn = self.childNode(withName: "backBtn") as? SKSpriteNode
        doneBg = self.childNode(withName: "//cmd-done-bg") as? SKSpriteNode
        donePopup = self.childNode(withName: "//cmd-done-popup") as? SKSpriteNode
        btnStageNext = self.childNode(withName: "//cmd-stage-next") as? SKSpriteNode
        btnStageMenu = self.childNode(withName: "//cmd-stage-menu") as? SKSpriteNode
        btnStageRestart = self.childNode(withName: "//cmd-stage-restart") as? SKSpriteNode
        boundary = self.childNode(withName: "boundary") as? SKSpriteNode
        satuKecil = self.childNode(withName: "satuKecil") as? SKSpriteNode
        satuSedang = self.childNode(withName: "satuSedang") as? SKSpriteNode
        satuBesar = self.childNode(withName: "satuBesar") as? SKSpriteNode
        duaKecil = self.childNode(withName: "duaKecil") as? SKSpriteNode
        duaSedeng = self.childNode(withName: "duaSedeng") as? SKSpriteNode
        duaBeser = self.childNode(withName: "duaBeser") as? SKSpriteNode
        tigaKecol = self.childNode(withName: "tigaKecol") as? SKSpriteNode
        tigaSedang = self.childNode(withName: "tigaSedang") as? SKSpriteNode
        tigaBesor = self.childNode(withName: "tigaBesor") as? SKSpriteNode
        meja = self.childNode(withName: "meja") as? SKSpriteNode
        
        meja.zPosition = -1
        boundary.zPosition = -1
        
        hideDonePopup()
        hideFase()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            
            guard !untouchableKecil.contains(location) else {
                return
            }
            guard !untouchableSedang.contains(location) else {
                return
            }
            guard !untouchableBesar.contains(location) else {
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
                guard let scene = SequenceStageThree(fileNamed: "SequenceStageThree") else { return }
                self.scene?.view?.presentScene(scene)
            } else if (touchedNode == btnStageRestart){
                hideDonePopup()
                restart()
            } else if touchedNode == btnStageMenu{
//                guard let scene = StageSelect(fileNamed: "StageSelect") else { return }
//                self.scene?.view?.presentScene(scene)
                
                changeSceneSelect()
            } else if touchedNode == backBtn{
                changeSceneSelect()
            }
        }
        
        guard let node = self.currentNode else {return}
        
        if targetKecil.contains(node.position) {
            if arrayKotak[0] == 0 && ((node.name?.contains("Kecil"))! || (node.name?.contains("Kecol"))! || (node.name?.contains("Kecul"))!){
                arrayKotak[0] = 1
                node.run(SKAction.move(to: pointKecil, duration: 0.1))
                
            } else{
                if (node.name?.contains("Sedang"))! || (node.name?.contains("Beser"))! || (node.name?.contains("Kecul"))!{
                    node.run(SKAction.move(to: initialSedang, duration: 0.1))
                } else if (node.name?.contains("Besar"))! || (node.name?.contains("Sedeng"))! || (node.name?.contains("Sedung"))!{
                    node.run(SKAction.move(to: initialBesar, duration: 0.1))
                }
            }
        } else if targetSedang.contains(node.position){
            if arrayKotak[1] == 0 && (node.name?.contains("Sedang"))! || (node.name?.contains("Sedeng"))! || (node.name?.contains("Sedung"))!{
                arrayKotak[1] = 1
                node.run(SKAction.move(to: pointSedang, duration: 0.1))
                
            } else{
                if (node.name?.contains("Kecil"))! || (node.name?.contains("Besor"))! || (node.name?.contains("Besur"))!{
                    node.run(SKAction.move(to: initialKecil, duration: 0.1))
                } else if (node.name?.contains("Besar"))! || (node.name?.contains("Sedung"))! || (node.name?.contains("Kecol"))!{
                    node.run(SKAction.move(to: initialBesar, duration: 0.1))
                } else{
                    node.run(SKAction.move(to: initialSedang, duration: 0.1))
                }
            }
        } else if targetBesar.contains(node.position){
            if arrayKotak[2] == 0 && (node.name?.contains("Besar"))! || (node.name?.contains("Besor"))! || (node.name?.contains("Besur"))! || (node.name?.contains("Beser"))!{
                arrayKotak[2] = 1
                node.run(SKAction.move(to: pointBesar, duration: 0.1))
                
            } else{
                if (node.name?.contains("Kecil"))! || (node.name?.contains("Besor"))! || (node.name?.contains("Besur"))!{
                    node.run(SKAction.move(to: initialKecil, duration: 0.1))
                } else if (node.name?.contains("Sedang"))! || (node.name?.contains("Beser"))! || (node.name?.contains("Kecul"))!{
                    node.run(SKAction.move(to: initialSedang, duration: 0.1))
                } else{
                    node.run(SKAction.move(to: initialBesar, duration: 0.1))
                }
            }
        } else{
            if (node.name?.contains("Kecil"))! || (node.name?.contains("Besor"))! || (node.name?.contains("Besur"))!{
                node.run(SKAction.move(to: initialKecil, duration: 0.1))
            } else if (node.name?.contains("Sedang"))! || (node.name?.contains("Beser"))! || (node.name?.contains("Kecul"))!{
                node.run(SKAction.move(to: initialSedang, duration: 0.1))
            } else if (node.name?.contains("Besar"))! || (node.name?.contains("Sedeng"))! || (node.name?.contains("Sedung"))! || (node.name?.contains("Kecol"))!{
                node.run(SKAction.move(to: initialBesar, duration: 0.1))
            }
        }
        self.currentNode = nil
        
        checkLogic()
        
    }
    
    func hideDonePopup() {
        print(#function)
        doneBg?.removeFromParent()
    }
    
    func showDonePopup() {
        print(#function)
        addChild(doneBg!)
        doneBg?.zPosition = 5
    }
    
    func restart(){
        arrayKotak = [0,0,0]
        hideFase()
        
        satuSedang.run(SKAction.move(to: initialSedang, duration: 0.1))
        satuKecil.run(SKAction.move(to: initialKecil, duration:  0.1))
        satuBesar.run(SKAction.move(to: initialBesar, duration:  0.1))
    }
    
    func hideFase(){
        duaKecil.isHidden = true
        duaSedeng.isHidden = true
        duaBeser.isHidden = true
        tigaKecol.isHidden = true
        tigaSedang.isHidden = true
        tigaBesor.isHidden = true
        
    }
    
    func changeSceneSelect(){
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //        let gameController = storyBoard.instantiateViewController(withIdentifier:
        //            "gameViewController")
        //        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        //        appDelegate.window?.rootViewController = gameController
        
        gameManager?.backToStageSelect()
    }
    
    func checkLogic(){
        if arrayKotak == [1,1,1]{
            
            if fase == 1{
                print(fase)
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 190)
                pointSedang = CGPoint(x: 642, y: 190)
                pointBesar = CGPoint(x: 1008, y: 190)
                
                duaKecil.isHidden = false
                duaSedeng.isHidden = false
                duaBeser.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 2{
                print(fase)
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 240)
                pointSedang = CGPoint(x: 642, y: 240)
                pointBesar = CGPoint(x: 1008, y: 240)
                
                tigaKecol.isHidden = false
                tigaSedang.isHidden = false
                tigaBesor.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 3{
                SKAction.wait(forDuration: 1)
                showDonePopup()
            }
        }
    }
}
