//
//  GameMenuScene.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/20/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    internal var background: SKSpriteNode!
    
    override init(size: CGSize)
    {
        super.init(size: size)
        self.scaleMode = .AspectFit
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
        loadComponents()
    }
    
    internal func loadComponents()
    {
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        for touch in (touches as! Set<UITouch>)
        {
            let location = touch.locationInNode(self)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        
    }
    
    internal func back()
    {
        if beforeBack() {
            backCommit()
        }
    }
    
    internal func beforeBack() -> Bool
    {
        return true
    }
    
    private func backCommit()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("Back", object:self)
    }
}
