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
    var rects: [[SKSpriteNode]] = []
    
    override func didMoveToView(view: SKView) {
        let horizontalCells = Int(self.size.width ) / pixelSize
        let   verticalCells = Int(self.size.height) / pixelSize
        conway = Conway(horizontalCells, verticalCells)
        
        addCells()
    }
    
    func addCells() {
        for i in 0..<conway.width {
            rects.append([])
            
            for j in 0..<conway.height {
                addCell(i, j)
            }
        }
    }
    
    func addCell(x: Int, _ y: Int) {
        let shape = SKSpriteNode(color: SKColor.blackColor(), size: cellSize)
        let xCord = x * pixelSize + pixelSize / 2
        let yCord = y * pixelSize + pixelSize / 2
        shape.position = CGPoint(x: xCord, y: yCord)
        
        rects[x].append(shape)
        updateCellView(x, y, alive: conway.alive(x, y))
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
        for _ in 1...10 {
            conway.nextGeneration()
        }
        
//        for x in 0..<conway.width {
//            for y in 0..<conway.height {
//                updateCellView(x, y, alive: conway.alive(x, y))
//            }
//        }
    }
    
    func updateCellView(x: Int, _ y: Int, alive: Bool) {
        rects[x][y].color = alive ? SKColor.whiteColor() : SKColor.blackColor()
    }
}
