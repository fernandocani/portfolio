//
//  LevelData.swift
//  MadBallArena
//
//  Created by Cristian Simioni Milani on 26/05/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

class LevelData {
    
    var id: Int
    var level: Int
    var name: String?
    var description: String?
    var thumbImage: String!
    var backgroundImage: String!
    var score: Int
    var time: Float?
    var nextLevelData: LevelData!
    var initialVector: CGPoint!
    var walls: [Wall]!
    
    init (_id: Int, _level: Int, _score: Int, time:Float!, initialVector: CGPoint!) {
        self.id = _id
        self.level = _level
        self.score = _score
        self.time = time
        self.initialVector = initialVector
        self.walls = [Wall]()
    }
}