//
//  Stars.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/25/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class Stars: SKSpriteNode
{
    internal var star1: SKSpriteNode!
    internal var star2: SKSpriteNode!
    internal var star3: SKSpriteNode!
    
    internal var texEnabled: SKTexture!
    internal var texDisabled: SKTexture!
    
    init(size: CGSize)
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        texEnabled = SKTexture(imageNamed: "star-enabled")
        texDisabled = SKTexture(imageNamed: "star-disabled")
        loadComponents()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadComponents()
    {
        let width = self.frame.width * 0.29
        let distance = self.frame.width * 0.01
        let size = CGSizeMake(width, width)
        
        star1 = SKSpriteNode(texture: texDisabled)
        star1.size = size
        star1.position = CGPointMake(-width - distance, 0)
        self.addChild(star1)
        
        star2 = SKSpriteNode(texture: texDisabled)
        star2.size = size
        self.addChild(star2)
        
        star3 = SKSpriteNode(texture: texDisabled)
        star3.position = CGPointMake(width + distance, 0)
        star3.size = size
        self.addChild(star3)
    }
    
    func setScore(score: Int)
    {
        star1.texture = score >= 1 ? texEnabled : texDisabled
        star2.texture = score >= 2 ? texEnabled : texDisabled
        star3.texture = score >= 3 ? texEnabled : texDisabled
    }
}