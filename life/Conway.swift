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
    var torus = true
    
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
    
    func set(_ x: Int, _ y: Int, alive: Bool) {
        cells[cellPos(x, y)] = alive
    }
    
    func nextGeneration() {
        var newCells = emptyGrid()
        
        for x in 0..<width {
            for y in 0..<height {
                newCells[cellPos(x, y)] = cellLives(x, y)
            }
        }
        
        cells = newCells
    }
    
    
    func neighborsOf(_ x: Int, _ y: Int) -> Int {
        var count = 0
        
        for dx in -1...1 {
            for dy in -1...1 {
                var newX = x + dx
                var newY = y + dy
                
                if torus {
                    newX = (width  + newX) % width
                    newY = (height + newY) % height
                }
                
                if (dx != 0 || dy != 0) &&
                    inOrder(0, newX, width - 1) &&
                    inOrder(0, newY, height - 1) &&
                    alive(newX, newY) {
                        count++
                }
                
            }
        }
        
        return count
    }
    
    func inOrder(a: Int, _ b: Int, _ c: Int) -> Bool {
        return a <= b && b <= c
    }
    
    func cellLives(_ x: Int, _ y: Int) -> Bool {
        let neighbors = neighborsOf(x, y)
        
        return neighbors == 3 || (neighbors == 2 && alive(x, y))
    }
    
    func emptyGrid() -> [Bool] {
        return Array(count: width * height, repeatedValue: false)
    }
    
    func initCells() {
        cells = emptyGrid()
    }
    
    func randomizeCells() {
        cells = emptyGrid().map { _ in randomBool() }
    }
    
    func setToGlider() {
        emptyGrid()
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
}