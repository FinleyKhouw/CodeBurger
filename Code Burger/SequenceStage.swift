//
//  GameScene.swift
//  Sorting Game CodeBurger
//
//  Created by Mirza Fachreza 2 on 09/07/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import SpriteKit

class SequenceStage: SKScene {
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
    var empatKecil: SKSpriteNode!
    var empatSedang: SKSpriteNode!
    var empatBesar: SKSpriteNode!
    var limaKecil: SKSpriteNode!
    var limaSedang: SKSpriteNode!
    var limaBesar: SKSpriteNode!
    var untouchableKecil = CGRect(x: 210, y: 50, width: 250, height: 250)
    var untouchableSedang =  CGRect(x: 580, y: 50, width: 250, height: 250)
    let untouchableBesar = CGRect(x: 909, y: 50, width: 250, height: 250)
    var targetKecil = CGRect(x: 210, y: 50, width: 250, height: 250)
    let targetSedang = CGRect(x: 580, y: 50, width: 250, height: 250)
    let targetBesar = CGRect(x: 909, y: 50, width: 250, height: 250)
    var pointKecil = CGPoint(x: 309, y: 160)
    var pointSedang = CGPoint(x: 642, y: 160)
    var pointBesar = CGPoint(x: 1008, y: 160)
    let initialKecil = CGPoint(x: 395, y: 491)
    let initialSedang = CGPoint(x: 636, y: 491)
    let initialBesar = CGPoint(x: 925, y: 491)
    var arrayKotak = [0,0,0]
    var fase = 1
   
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        duaKecil = childNode(withName: "duaKecil") as? SKSpriteNode
        duaSedang = self.childNode(withName: "duaSedang") as? SKSpriteNode
        duaBesar = self.childNode(withName: "duaBesar") as? SKSpriteNode
        tigaKecil = self.childNode(withName: "tigaKecil") as? SKSpriteNode
        tigaSedang = self.childNode(withName: "tigaSedang") as? SKSpriteNode
        tigaBesar = self.childNode(withName: "tigaBesar") as? SKSpriteNode
        empatKecil = self.childNode(withName: "empatKecil") as? SKSpriteNode
        empatSedang = self.childNode(withName: "empatSedang") as? SKSpriteNode
        empatBesar = self.childNode(withName: "empatBesar") as? SKSpriteNode
        limaKecil = self.childNode(withName: "limaKecil") as? SKSpriteNode
        limaSedang = self.childNode(withName: "limaSedang") as? SKSpriteNode
        limaBesar = self.childNode(withName: "limaBesar") as? SKSpriteNode
        
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
                } else if fase == 4{
                    if (node.name?.contains("empat"))!{
                        self.currentNode = node
                    }
                } else if fase == 5{
                    if (node.name?.contains("lima"))!{
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
        empatKecil.isHidden = true
        empatSedang.isHidden = true
        empatBesar.isHidden = true
        limaKecil.isHidden = true
        limaSedang.isHidden = true
        limaBesar.isHidden = true
        
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
                
                pointKecil = CGPoint(x: 309, y: 210)
                pointSedang = CGPoint(x: 642, y: 210)
                pointBesar = CGPoint(x: 1008, y: 210)
                
                tigaKecil.isHidden = false
                tigaSedang.isHidden = false
                tigaBesar.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 3{
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 240)
                pointSedang = CGPoint(x: 642, y: 240)
                pointBesar = CGPoint(x: 1008, y: 240)
                
                empatKecil.isHidden = false
                empatSedang.isHidden = false
                empatBesar.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 4{
                fase += 1
                
                pointKecil = CGPoint(x: 309, y: 240)
                pointSedang = CGPoint(x: 642, y: 240)
                pointBesar = CGPoint(x: 1008, y: 240)
                
                limaKecil.isHidden = false
                limaSedang.isHidden = false
                limaBesar.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 5{
                print ("HORE")
            }
        }
        
        
    }
}
