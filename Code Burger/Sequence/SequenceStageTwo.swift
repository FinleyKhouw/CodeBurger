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
    
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        boundary = self.childNode(withName: "boundary") as? SKSpriteNode
        duaKecil = self.childNode(withName: "duaKecil") as? SKSpriteNode
        duaSedeng = self.childNode(withName: "duaSedeng") as? SKSpriteNode
        duaBeser = self.childNode(withName: "duaBeser") as? SKSpriteNode
        tigaKecol = self.childNode(withName: "tigaKecol") as? SKSpriteNode
        tigaSedang = self.childNode(withName: "tigaSedang") as? SKSpriteNode
        tigaBesor = self.childNode(withName: "tigaBesor") as? SKSpriteNode
        meja = self.childNode(withName: "meja") as? SKSpriteNode
        
        meja.zPosition = -1
        boundary.zPosition = -1
        
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
    
    func hideFase(){
        duaKecil.isHidden = true
        duaSedeng.isHidden = true
        duaBeser.isHidden = true
        tigaKecol.isHidden = true
        tigaSedang.isHidden = true
        tigaBesor.isHidden = true
        
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
                
                pointKecil = CGPoint(x: 309, y: 220)
                pointSedang = CGPoint(x: 642, y: 220)
                pointBesar = CGPoint(x: 1008, y: 220)
                
                tigaKecol.isHidden = false
                tigaSedang.isHidden = false
                tigaBesor.isHidden = false
                
                arrayKotak = [0,0,0]
            } else if fase == 3{
                print("HORE")
            }
        }
    }
}
