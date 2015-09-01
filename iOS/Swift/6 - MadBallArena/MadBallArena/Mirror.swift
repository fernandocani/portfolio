//
//  Square.swift
//  MadBallArena
//
//  Created by Fernando Cani on 5/25/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class Mirror: GameObject
{
    internal let ACT_LIFETIME: String = "lifetime"
    
    internal var lifetime: NSTimeInterval = 0
    internal var breakHits: Int = 0
    
    private var lifetimeAction: SKAction! = nil
    
    init()
    {
        let texture = SKTexture(imageNamed: "bg_rect")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.name = Constants.nameMirror
    }
    
    init(imageNamed: String)
    {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func validateFactor()
    {
        self.colorBlendFactor = self.size.width > Constants.mirrorMinSize ? 0.0 : 1.0
    }
    
    func build()
    {
        setPhysics()
    }
    
    func setPhysics()
    {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size, center: CGPointMake(self.size.width/2, self.size.height/2))
        self.physicsBody!.categoryBitMask = Constants.collisionCategoryMirror
        self.physicsBody!.collisionBitMask = Constants.collisionCategoryBall
        self.physicsBody!.contactTestBitMask = Constants.collisionCategoryBall
        self.physicsBody!.usesPreciseCollisionDetection = true
    }
    
    func removePhysics()
    {
        self.physicsBody = nil
    }
    
    func setLifetime()
    {
        stopLifetime()
        lifetimeAction = SKAction.sequence([
            SKAction.waitForDuration(self.lifetime),
            SKAction.removeFromParent()
        ])
        self.runAction(lifetimeAction, withKey: ACT_LIFETIME)
    }
    
    func stopLifetime()
    {
        self.removeActionForKey(ACT_LIFETIME)
    }
    
    func destroy()
    {
        
    }
}