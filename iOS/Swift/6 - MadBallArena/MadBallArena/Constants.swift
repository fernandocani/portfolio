//
//  File.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/27/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class Constants
{
    // Names
    static let nameBall: String = "ball"
    static let nameMirror: String = "mirror"
    static let nameHole: String = "hole"
    
    static let mirrorMinSize: CGFloat = 100.0
    static let mirrorMaxSize: CGFloat = 200.0
    static let spreadPiecesDistance: UInt32 = 70
    
    // Bit collisions categories
    static let collisionCategoryBall: UInt32 = 0x1 << 0
    static let collisionCategoryMirror: UInt32 = 0x1 << 1
    static let collisionCategoryHole: UInt32 = 0x1 << 2
}