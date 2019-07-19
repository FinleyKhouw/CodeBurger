//
//  SequenceStageOne.swift
//  Code Burger
//
//  Created by Mirza Fachreza 2 on 18/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit

class SequenceStageOne: SKScene {
    var boundary: SKSpriteNode!
    var piringSatu: SKSpriteNode!
    var piringDua: SKSpriteNode!
    var piringTiga: SKSpriteNode!
    var satuKecil: SKSpriteNode!
    var satuSedang: SKSpriteNode!
    var satuBesar: SKSpriteNode!
    var duaKecil: SKSpriteNode!
    var duaSedang: SKSpriteNode!
    var duaBesar: SKSpriteNode!
    var tigaKecil: SKSpriteNode!
    var tigaSedang: SKSpriteNode!
    var tigaBesar: SKSpriteNode!
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
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        duaKecil = self.childNode(withName: "duaKecil") as? SKSpriteNode
        duaSedang = self.childNode(withName: "duaSedang") as? SKSpriteNode
        duaBesar = self.childNode(withName: "duaBesar") as? SKSpriteNode
        tigaKecil = self.childNode(withName: "tigaKecil") as? SKSpriteNode
        tigaSedang = self.childNode(withName: "tigaSedang") as? SKSpriteNode
        tigaBesar = self.childNode(withName: "tigaBesar") as? SKSpriteNode
        
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
        guard let node = self.currentNode else {return}
        
        if targetKecil.contains(node.position) {
            if arrayKotak[0] == 0 && (node.name?.contains("Kecil"))!{
                arrayKotak[0] = 1
                node.run(SKAction.move(to: pointKecil, duration: 0.1))
                
            } else{
                if (node.name?.contains("Sedang"))!{
                    node.run(SKAction.move(to: initialSedang, duration: 0.1))
                } else if (node.name?.contains("Besar"))!{
                    node.run(SKAction.move(to: initialBesar, duration: 0.1))
                }
            }
        } else if targetSedang.contains(node.position){
            if arrayKotak[1] == 0 && (node.name?.contains("Sedang"))!{
                arrayKotak[1] = 1
                node.run(SKAction.move(to: pointSedang, duration: 0.1))
                
            } else{
                if (node.name?.contains("Kecil"))!{
                    node.run(SKAction.move(to: initialKecil, duration: 0.1))
                    node.isUserInteractionEnabled = false
                    print(node.name!)
                } else if (node.name?.contains("Besar"))!{
                    node.run(SKAction.move(to: initialBesar, duration: 0.1))
                }
            }
        } else if targetBesar.contains(node.position){
            if arrayKotak[2] == 0 && (node.name?.contains("Besar"))!{
                arrayKotak[2] = 1
                node.run(SKAction.move(to: pointBesar, duration: 0.1))
                
            } else{
                if (node.name?.contains("Kecil"))!{
                    node.run(SKAction.move(to: initialKecil, duration: 0.1))
                } else if (node.name?.contains("Sedang"))!{
                    node.run(SKAction.move(to: initialSedang, duration: 0.1))
                }
            }
        } else{
            if (node.name?.contains("Kecil"))!{
                node.run(SKAction.move(to: initialKecil, duration: 0.1))
            } else if (node.name?.contains("Sedang"))!{
                node.run(SKAction.move(to: initialSedang, duration: 0.1))
            } else if (node.name?.contains("Besar"))!{
                node.run(SKAction.move(to: initialBesar, duration: 0.1))
            }
        }
        
        self.currentNode = nil
        
        checkLogic()
        
    }
    
    func hideFase(){
        duaKecil.isHidden = true
        duaSedang.isHidden = true
        duaBesar.isHidden = true
        tigaKecil.isHidden = true
        tigaSedang.isHidden = true
        tigaBesar.isHidden = true
        
    }
    
    func checkLogic(){
        if arrayKotak == [1,1,1]{
            print("Mantap")
            if fase == 1{
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 190)
                pointSedang = CGPoint(x: 642, y: 190)
                pointBesar = CGPoint(x: 1008, y: 190)
                
                duaKecil.isHidden = false
                duaSedang.isHidden = false
                duaBesar.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 2{
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 220)
                pointSedang = CGPoint(x: 642, y: 220)
                pointBesar = CGPoint(x: 1008, y: 220)
                
                tigaKecil.isHidden = false
                tigaSedang.isHidden = false
                tigaBesar.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 3{
                print("Hore")
            }
        }
    }
}
