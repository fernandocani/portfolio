//
//  Hole.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/29/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class Hole: GameObject
{
    init()
    {
        let texture = SKTexture(imageNamed: "hole")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.name = Constants.nameBall
        setPhysics()
    }
    
    init(imageNamed: String, size: CGSize)
    {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        setPhysics()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePhysics()
    {
        setPhysics()
    }
    
    func setPhysics()
    {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3)
        self.physicsBody!.categoryBitMask = Constants.collisionCategoryHole
        self.physicsBody!.collisionBitMask = Constants.collisionCategoryBall
        self.physicsBody!.contactTestBitMask = Constants.collisionCategoryBall
        self.physicsBody!.usesPreciseCollisionDetection = true
    }
}
