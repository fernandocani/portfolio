//
//  LevelPanel.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/22/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class LevelPanel: SKSpriteNode
{
    static let ID: String = "LevelPanel"
    
    internal var data: LevelData
    internal var image: SKSpriteNode!
    internal var title: SKLabelNode!
    internal var stars: Stars!
    
    init(data: LevelData, size: CGSize)
    {
        self.data = data
        
        let texture = SKTexture(imageNamed: "background")
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        
        self.name = LevelPanel.ID
        loadComponents()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadComponents()
    {
        let contextWidth = self.frame.width * 0.8
        
        title = SKLabelNode(text: data.name!)
        title.fontName = "AmericanTypewriter-Bold"
        title.fontSize = 15
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        title.position = CGPointMake(0, self.frame.height/2 * 0.68)
        title.name = LevelPanel.ID
        self.addChild(title)
        
        image = SKSpriteNode(imageNamed: data.thumbImage)
        image.size = CGSizeMake(contextWidth, contextWidth / 1.5)
        image.position = CGPointMake(0, self.frame.height/2 * 0.06)
        image.name = LevelPanel.ID
        self.addChild(image)
        
        stars = Stars(size: CGSizeMake(contextWidth, self.frame.height * 0.25))
        stars.position = CGPointMake(0, -(self.frame.height/2 * 0.68))
        stars.setScore(data.score)
        stars.name = LevelPanel.ID
        self.addChild(stars)
    }
        
    func getLevelData() -> LevelData
    {
        return data;
    }
}