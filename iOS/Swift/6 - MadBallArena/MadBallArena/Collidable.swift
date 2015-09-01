//
//  Collidable.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/28/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

protocol Collidable
{
    func onCollision(node: SKNode)
}