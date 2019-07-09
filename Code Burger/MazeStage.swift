//
//  MazeStage.swift
//  Code Burger
//
//  Created by Finley Khouwira on 08/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit

class MazeStage: SKScene {
    
    var backgroundScene = SKShapeNode()
    var playButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    var leftTapped = SKSpriteNode()
    var rightTapped = SKSpriteNode()
    var upTapped = SKSpriteNode()
    var downTapped = SKSpriteNode()
    var lineSeperator = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        backgroundScene = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 400, height: 1024))
        backgroundScene.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addChild(backgroundScene)
        
        lineSeperator = SKShapeNode(rect: CGRect(x: 0, y: 200, width: 400, height: 10))
        lineSeperator.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addChild(lineSeperator)
        
        playButton = SKSpriteNode(imageNamed: "run-tapped")
        playButton.position = CGPoint(x: 900, y: 100)
        playButton.size = CGSize(width: 100, height: 100)
        addChild(playButton)
        
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPoint(x: 50, y: 970)
        backButton.size = CGSize(width: 50, height: 50)
        addChild(backButton)
        
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
        
        addChild(rightTapped)
        addChild(leftTapped)
        addChild(upTapped)
        addChild(downTapped)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        var commandLocation = CGPoint(x: 250, y: 800)
        
        if let body = physicsWorld.body(at: touchLocation){
            if body.node!.name == "up" {
                let firstCommand = SKSpriteNode(imageNamed: "up-tapped")
                firstCommand.position = commandLocation
                firstCommand.size = CGSize(width: 75, height: 75)
                addChild(firstCommand)
            } else if body.node!.name == "down" {
                let firstCommand = SKSpriteNode(imageNamed: "down-tapped")
                firstCommand.position = commandLocation
                firstCommand.size = CGSize(width: 75, height: 75)
                addChild(firstCommand)
            } else if body.node!.name == "left" {
                let firstCommand = SKSpriteNode(imageNamed: "left-tapped")
                firstCommand.position = commandLocation
                firstCommand.size = CGSize(width: 75, height: 75)
                addChild(firstCommand)
            } else if body.node!.name == "right" {
                let firstCommand = SKSpriteNode(imageNamed: "right-tapped")
                firstCommand.position = commandLocation
                firstCommand.size = CGSize(width: 75, height: 75)
                addChild(firstCommand)
            } else {}
        }
    }
}
