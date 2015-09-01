//
//  NormalSquare.swift
//  MadBallArena
//
//  Created by Fernando Cani on 5/25/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class NormalMirror: Mirror
{
    internal let timeExplodeAnimation = 1.5
    internal var pieces: Array<SKSpriteNode> = []
    
    override init()
    {
        super.init(imageNamed: "glass")
        self.color = UIColor.redColor()
        self.colorBlendFactor = 1.0
        self.anchorPoint = CGPointMake(0, 0.5)
        self.alpha = 0.5
        self.size = CGSizeMake(0, 10)
        
        self.lifetime = 3
        self.breakHits = 1
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setPhysics()
    {
        super.setPhysics()
        
        self.physicsBody!.friction          = 0.0
        self.physicsBody!.restitution       = 1.0
        self.physicsBody!.linearDamping     = 0.0
        self.physicsBody!.dynamic           = false
        
        self.colorBlendFactor = 0.0
        self.alpha = 1.0
        
        setLifetime()
    }
    
    override func onCollision(node: SKNode)
    {
        super.onCollision(node)
        destroy()
    }
    
    override func destroy()
    {
        super.destroy()
        
        removePhysics()
        playExplode()
        self.runAction(SKAction.sequence([
            SKAction.waitForDuration(timeExplodeAnimation),
            SKAction.removeFromParent()
        ]))
    }
    
    internal func playExplode()
    {
        self.texture = SKTexture(imageNamed: "space")
        let piecesSize = arc4random_uniform(2) + 2
        let pieceWidth = self.size.width / CGFloat(piecesSize)
        pieces = []
        for i in 0...piecesSize
        {
            let piece = SKSpriteNode(imageNamed: "glass")
            piece.size = self.size
            piece.size.width = pieceWidth
            piece.position = CGPointMake((pieceWidth * CGFloat(i)), 0)
            pieces.append(piece)
            
            // Animation
            let spread = Constants.spreadPiecesDistance
            let negX = arc4random_uniform(2) == 0
            let negY = arc4random_uniform(2) == 0
            
            let x = negX ? Int(arc4random_uniform(spread))*(-1) : Int((arc4random_uniform(spread)))
            let y = negY ? Int(arc4random_uniform(spread))*(-1) : Int((arc4random_uniform(spread)))
            piece.runAction(SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(y)), duration: timeExplodeAnimation))
            piece.runAction(SKAction.fadeOutWithDuration(timeExplodeAnimation + 1))
            piece.runAction(SKAction.rotateToAngle(CGFloat(M_PI * 2/Double(arc4random_uniform(8))), duration: timeExplodeAnimation))
            
            self.addChild(piece)
        }
    }
}