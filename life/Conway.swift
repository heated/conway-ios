//
//  Conway.swift
//  life
//
//  Created by Edward Swernofsky on 3/17/16.
//  Copyright © 2016 Edward Swernofsky. All rights reserved.
//

import Foundation

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0
}


class Conway {
    var width  = 10
    var height = 10
    var cells: [Bool] = []
    var nextGenerationCells: [Bool] = []
    var torus = false
    var running = false
    var generations = 0
    
    init(_ width: Int, _ height: Int) {
        self.width  = width
        self.height = height
        initCells()
        randomizeCells()
    }
    
    func cellPos(_ x: Int, _ y: Int) -> Int {
        return x * height + y
    }
    
    func alive(_ x: Int, _ y: Int) -> Bool {
        return cells[cellPos(x, y)]
    }
    
    func alive(pos: Int) -> Bool {
        return cells[pos]
    }
    
    func set(_ x: Int, _ y: Int, alive: Bool) {
        cells[cellPos(x, y)] = alive
    }
    
    func nextGeneration() {
        for pos in 0 ..< cells.count {
            nextGenerationCells[pos] = cellLives(pos)
        }
        
        swap(&cells, &nextGenerationCells)
        generations++
    }
    
    func cellsPerSecond(testLength: Int = 100) -> Double {
        let start = NSDate().timeIntervalSince1970
        
        for _ in 1...testLength {
            nextGeneration()
        }
        
        let end = NSDate().timeIntervalSince1970
        
        return Double(testLength * cells.count) / (end - start)
    }
    
    func neighborsOf(pos: Int) -> Int {
        let x = pos / height
        let y = pos % height
        var count = 0
        
        for dx in -1...1 {
            for dy in -1...1 {
                if (dx != 0 || dy != 0) {
                    
                    var newX = x + dx
                    var newY = y + dy
                    
                    if torus {
                        newX = (width  + newX) % width
                        newY = (height + newY) % height
                        
                        if alive(newX, newY) {
                            count++
                        }
                        
                    } else if validPos(newX, newY) &&
                              alive(newX, newY) {
                        count++
                    }
                }
            }
        }
        
        return count
    }
    
    func validPos(_ x: Int, _ y: Int) -> Bool {
        return 0 <= x     &&
               0 <= y     &&
               x <  width &&
               y <  height
    }
    
    func cellLives(pos: Int) -> Bool {
        let neighbors = neighborsOf(pos)
        
        return neighbors == 3 || (neighbors == 2 && alive(pos))
    }
    
    func emptyGrid() -> [Bool] {
        return Array(count: width * height, repeatedValue: false)
    }
    
    func initCells() {
        cells = emptyGrid()
        nextGenerationCells = emptyGrid()
    }
    
    func randomizeCells() {
        cells = emptyGrid().map { _ in randomBool() }
    }
    
    func setToGlider() {
        initCells()
        set(0, 1, alive: true)
        set(1, 2, alive: true)
        set(2, 0, alive: true)
        set(2, 1, alive: true)
        set(2, 2, alive: true)
    }
    
    func toggleTorus() -> Bool {
        torus = !torus
        return torus
    }
    
    func run() {
        if running {
            nextGeneration()
            
            NSOperationQueue().addOperationWithBlock() {
                self.run()
            }
        }
    }
}