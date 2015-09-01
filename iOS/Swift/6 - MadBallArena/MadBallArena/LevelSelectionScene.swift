//
//  LevelSelectionScene.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/20/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class LevelSelectionScene: GameScene
{
    internal var levelPanels: Array<LevelPanel> = []
    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
    }
    
    override internal func loadComponents()
    {
        // Background
        background = SKSpriteNode(imageNamed: "initial-screen")
        background.size = self.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(background)
        
        var shade = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 2058, height: 1058))
        shade.alpha = 0.5
        shade.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(shade)
        
        // Levels
        
        let panelWidth = self.frame.width * 0.15
        let panelHeight = 1.2 * panelWidth
        let distanceX = self.frame.width * 0.02
        let distanceY = self.frame.width * 0.02
        let widthTotal = (4 * panelWidth) + (3 * distanceX)
        let heightTotal = (2 * panelHeight) + distanceY
        
        let initialX = ((self.frame.width - widthTotal) / 2) + (panelWidth / 2)
        let initialY = (self.frame.height - ((self.frame.height - heightTotal) / 2)) - (panelHeight / 2)
        
        var x = CGFloat(initialX)
        var y = CGFloat(initialY)
        
        for i in 0...7
        {
            let data = LevelStore.sharedInstance.getLevelByIndex(i)
            if i - 1 >= 0 {
                levelPanels[i-1].data.nextLevelData = data
            }
            
            let lvl = LevelPanel(data: data, size: CGSizeMake(panelWidth, panelHeight))
            lvl.position = CGPointMake(x, y)
            self.addChild(lvl)
            
            // Positioning
            if (i + 1) % 4 == 0
            {
                y -= (panelHeight + distanceY)
                x = initialX
            }
            else
            {
                x += (panelWidth + distanceX)
            }
            
            levelPanels.append(lvl)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        super.touchesBegan(touches, withEvent: event)
        for touch in (touches as! Set<UITouch>)
        {
            let location = touch.locationInNode(self)
            for panel in levelPanels
            {
                if(panel.containsPoint(location))
                {
                    GameViewController.instance.initLevel(panel.getLevelData())
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        super.update(currentTime)
    }
}