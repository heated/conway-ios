//
//  GameScene.swift
//  lifeMac
//
//  Created by Andrew Snow on 4/5/16.
//  Copyright (c) 2016 Edward Swernofsky. All rights reserved.
//

import SpriteKit

private let pixelSize = 40

class GameScene: SKScene {
    var conway = Conway(0, 0) // dummy value
    var rects: [SKSpriteNode] = []
    
    let cellSize = CGSize(width: pixelSize, height: pixelSize)
    let white = SKColor.whiteColor()
    let black = SKColor.blackColor()
    
    override func didMoveToView(view: SKView) {
        let w = Int(size.width) / pixelSize
        let h = Int(size.height) / pixelSize
        conway = Conway(w, h)
        
        print(w, h)
        
        addCells()
        
        print(conway.cellsPerSecond())
        
        conway.running = true
        conway.run()
    }
    
    func addCells() {
        for i in 0 ..< conway.width {
            for j in 0 ..< conway.height {
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
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
    }
    
    override func update(currentTime: CFTimeInterval) {
        for pos in 0 ..< self.conway.cells.count {
            self.rects[pos].color = self.conway.alive(pos) ? self.white : self.black
        }
    }
}
