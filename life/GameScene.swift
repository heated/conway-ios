//
//  GameScene.swift
//  life
//
//  Created by Edward Swernofsky on 3/17/16.
//  Copyright (c) 2016 Edward Swernofsky. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var width: Int = 10
    var height: Int = 10
    var cells2 = Array(count: 10, repeatedValue: false)
    var cells: [[Bool]] = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let midX = CGRectGetMidX(frame)
        let midY = CGRectGetMidY(frame)
        let middle = CGPoint(x: midX, y: midY)
        
        let upperRight = CGPoint(x: CGRectGetMaxX(frame), y: CGRectGetMaxY(frame))
        
        let square = CGSize(width: 100, height: 100)
        
        addRect(middle, square, SKColor.redColor())
        addRect(CGPointZero, square, SKColor.blueColor())
        addRect(50, 200, 100, 100, SKColor.greenColor())
        addRect(upperRight, square, SKColor.whiteColor())
    }
    
    func initializeCells() {
        
    }
    
    func addCells() {
        initializeCells()
        
        for i in 0...width {
            for j in 0...height {
                
            }
        }
        
    }
    
    func addRect(_ x: Int, _ y: Int, _ width: Int, _ height: Int, _ color: SKColor) {
        let pos = CGPoint(x: x, y: y)
        let size = CGSize(width: width, height: height)
        addRect(pos, size, color)
    }
    
    func addRect(_ position: CGPoint, _ size: CGSize, _ color: SKColor) {
        let shape = SKSpriteNode(color: color, size: size)
        shape.position = position
        self.addChild(shape)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let square = CGSize(width: 100, height: 100)
            addRect(location, square, SKColor.whiteColor())
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
