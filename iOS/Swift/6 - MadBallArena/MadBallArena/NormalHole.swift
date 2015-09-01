//
//  NormalHole.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/29/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class NormalHole: Hole
{
    override func setPhysics()
    {
        super.setPhysics()
        
        self.physicsBody!.dynamic = false
        self.physicsBody!.allowsRotation = false
    }
    
    override func onCollision(node: SKNode)
    {
        super.onCollision(node)
        if node.name != Constants.nameBall {
            return
        }
        
        if let scene = self.parent as? LevelScene {
            scene.objectiveCompleted(self)
        }
    }
}
