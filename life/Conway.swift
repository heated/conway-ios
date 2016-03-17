//
//  Conway.swift
//  life
//
//  Created by Edward Swernofsky on 3/17/16.
//  Copyright © 2016 Edward Swernofsky. All rights reserved.
//

import Foundation

class Conway {
    var width: Int = 10
    var height: Int = 10
    var cells: [[Bool]] = []
    
    init() {
        emptyGrid()
    }
    
    func emptyGrid() {
        cells = Array(count: width, repeatedValue: Array(count: height, repeatedValue: false))
    }
    
    func setToGlider() {
        
    }
}