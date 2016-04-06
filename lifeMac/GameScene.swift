//
//  GameScene.swift
//  lifeMac
//
//  Created by Andrew Snow on 4/5/16.
//  Copyright (c) 2016 Edward Swernofsky. All rights reserved.
//

import SpriteKit

private let pixelSize = 10

class GameScene: SKScene {
    var conway = Conway(10, 10) // dummy value
    let cellSize = CGSize(width: pixelSize, height: pixelSize)
    var rects: [[SKSpriteNode]] = []
    
    override func didMoveToView(view: SKView) {
        let h = Int(size.height) / pixelSize
        let w = Int(size.width) / pixelSize
        conway = Conway(w, h)
        
        addCells()
    }
    
    func addCells() {
        for i in 0 ..< conway.width {
            rects.append([])
            for j in 0 ..< conway.height {
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
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
    }
    
    override func update(currentTime: CFTimeInterval) {
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
