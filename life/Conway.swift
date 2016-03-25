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
    var width: Int = 10
    var height: Int = 10
    var cells: [[Bool]] = []
    
    init(_ width: Int, _ height: Int) {
        self.width  = width
        self.height = height
        initCells()
        randomizeCells()
    }
    
    func nextGeneration() {
        var newCells = emptyGrid()
        
        for x in 0..<width {
            for y in 0..<height {
                newCells[x][y] = cellLives(x, y)
            }
        }
        
        cells = newCells
    }
    
    func neighborsOf(_ x: Int, _ y: Int) -> Int {
        var count = 0
        
        for dx in -1...1 {
            for dy in -1...1 {
                let newX = x + dx
                let newY = y + dy
                
                if (dx != 0 || dy != 0) &&
                    inOrder(0, newX, width - 1) &&
                    inOrder(0, newY, height - 1) &&
                    cells[newX][newY] {
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
        
        return neighbors == 3 || (neighbors == 2 && cells[x][y])
    }
    
    func emptyGrid() -> [[Bool]] {
        return Array(count: width, repeatedValue: Array(count: height, repeatedValue: false))
    }
    
    func initCells() {
        cells = emptyGrid()
    }
    
    func randomizeCells() {
        for x in 0..<width {
            for y in 0..<height {
                cells[x][y] = randomBool()
            }
        }
    }
    
    func setToGlider() {
        emptyGrid()
        cells[0][1] = true
        cells[1][2] = true
        cells[2][0] = true
        cells[2][1] = true
        cells[2][2] = true
    }
}