//
//  File.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/22/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class NormalBall: Ball
{
    override init()
    {
        super.init(imageNamed: "normal-ball")
        self.maxSpeed = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setPhysics()
    {
        super.setPhysics()
        
        self.physicsBody!.dynamic = true
        self.physicsBody!.friction        = 0.0
        self.physicsBody!.restitution     = 1.0
        self.physicsBody!.linearDamping   = 0.0
        self.physicsBody!.allowsRotation = true
    }
}