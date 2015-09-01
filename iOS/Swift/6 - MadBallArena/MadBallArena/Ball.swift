//
//  Ball.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/22/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class Ball: GameObject
{
    internal var maxSpeed:CGFloat = 0
    internal var ballSize:CGSize = CGSizeMake(30.0, 30.0)
    
    init()
    {
        let texture = SKTexture(imageNamed: "normal-ball")
        super.init(texture: texture, color: UIColor.clearColor(), size: ballSize)
        self.name = Constants.nameBall
        setPhysics()
    }
    
    init(imageNamed: String)
    {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clearColor(), size: ballSize)
        self.name = Constants.nameBall
        setPhysics()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhysics()
    {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.size.width/2)
        self.physicsBody!.categoryBitMask = Constants.collisionCategoryBall
        self.physicsBody!.collisionBitMask = Constants.collisionCategoryMirror | Constants.collisionCategoryHole
        self.physicsBody!.contactTestBitMask = Constants.collisionCategoryMirror | Constants.collisionCategoryHole
        self.physicsBody!.usesPreciseCollisionDetection = true
    }
    
    func setImpulse(impulse: CGVector)
    {
        let v = impulse.normalized
        self.physicsBody!.applyImpulse(CGVectorMake(v.x * maxSpeed, v.x * maxSpeed))
    }
}