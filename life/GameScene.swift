//
//  GameScene.swift
//  life
//
//  Created by Edward Swernofsky on 3/17/16.
//  Copyright (c) 2016 Edward Swernofsky. All rights reserved.
//

import SpriteKit

private let pixelSize = 10

class GameScene: SKScene {
    var conway = Conway(10, 10)
    let cellSize = CGSize(width: pixelSize, height: pixelSize)
    var rects: [SKSpriteNode] = []
    let white = SKColor.whiteColor()
    let black = SKColor.blackColor()
    
    override func didMoveToView(view: SKView) {
        let horizontalCells = Int(size.width ) / pixelSize
        let   verticalCells = Int(size.height) / pixelSize
        conway = Conway(horizontalCells, verticalCells)
        
        print(horizontalCells, verticalCells)
        
        addCells()
        
//        print(conway.cellsPerSecond())

//        multithreading
//        conway.running = true
//        conway.run()
    }
    
    func addCells() {
        for i in 0..<conway.width {
            for j in 0..<conway.height {
                addCell(i, j)
            }
        }
    }
    
    func addCell(x: Int, _ y: Int) {
        let shape = SKSpriteNode(color: black, size: cellSize)
        
        let xCord = x * pixelSize + pixelSize / 2
        let yCord = y * pixelSize + pixelSize / 2
        shape.position = CGPoint(x: xCord, y: yCord)
        //        shape.shouldRasterize = true
        
        rects.append(shape)
        self.addChild(shape)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
//         Called before each frame is rendered 
        conway.nextGeneration()
        
        for pos in 0 ..< self.conway.cells.count {
            rects[pos].color = conway.alive(pos) ? white : black
        }
    }
}
