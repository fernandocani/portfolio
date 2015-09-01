//
//  Wall.swift
//  MadBallArena
//
//  Created by Cristian Simioni Milani on 01/06/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

class Wall {
    
    internal var points = [CGPoint]()
    
    init () {
        
    }
    
    func addPoints(point: CGPoint) {
        points.append(point)
    }
    
    func countPoint() -> (Int) {
        return points.count
    }
    
}
