//
//  MenuScene.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/20/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class MenuScene: GameScene
{
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
        
        // Buttons
        let buttonSize = (width: 200.00, height: 50.00)
        let buttonImageNormal = (play: "bt-play.png", options: "bt-options.png", about: "bt-credits.png")
        let buttonImageHighlighted = (play: "bt-play.png", options: "bt-options.png", about: "bt-credits.png")
        let buttonTitle = (play: "", options: "", about: "")
        
        var yPosition = CGRectGetMidY(self.frame) - (self.frame.height * 0.08)
        var xPosition = CGRectGetMidX(self.frame) - (self.frame.height * 0.035)
        let topSpace = CGFloat(CGFloat(buttonSize.height) + (self.frame.height * 0.04))
        
        // Play
        var playButton: SKButton = SKButton(normalImageNamed: buttonImageNormal.play, highlightedImageNamed: buttonImageHighlighted.play, size: CGSize(width: buttonSize.width, height: buttonSize.height), buttonFunc: tappedPlayButton)
        playButton.position = CGPointMake(xPosition, yPosition)
        playButton.setString(.Normal, string: buttonTitle.play, stringColor: UIColor.whiteColor())
        self.addChild(playButton)
        
        // Options
        yPosition -= topSpace
        var optionsButton: SKButton = SKButton(normalImageNamed: buttonImageNormal.options, highlightedImageNamed: buttonImageHighlighted.options, size: CGSize(width: buttonSize.width, height: buttonSize.height), buttonFunc: tappedOptionsButton)
        optionsButton.position = CGPointMake(xPosition, yPosition)
        optionsButton.setString(.Normal, string: buttonTitle.options, stringColor: UIColor.whiteColor())
        //self.addChild(optionsButton)
        
        // About
        yPosition -= topSpace
        var aboutButton: SKButton = SKButton(normalImageNamed: buttonImageNormal.about, highlightedImageNamed: buttonImageHighlighted.about, size: CGSize(width: buttonSize.width, height: buttonSize.height), buttonFunc: tappedAboutButton)
        aboutButton.position = CGPointMake(xPosition, yPosition)
        aboutButton.setString(.Normal, string: buttonTitle.about, stringColor: UIColor.whiteColor())
        //self.addChild(aboutButton)
        
        // SIZES
        var normalW = playButton.size.width
        var resizedW = self.frame.width * 0.10
        var r = normalW / resizedW
        playButton.size = CGSizeMake(resizedW, playButton.size.height / r)
        
        normalW = optionsButton.size.width
        resizedW = self.frame.width * 0.17
        r = normalW / resizedW
        optionsButton.size = CGSizeMake(resizedW, optionsButton.size.height / r)
        
        normalW = aboutButton.size.width
        resizedW = self.frame.width * 0.17
        r = normalW / resizedW
        aboutButton.size = CGSizeMake(resizedW, aboutButton.size.height / r)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        super.touchesBegan(touches, withEvent: event)
        for touch in (touches as! Set<UITouch>)
        {
            let location = touch.locationInNode(self)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        super.update(currentTime)
    }
    
    // Button Actions
    func tappedPlayButton(button: SKButton)
    {
        GameViewController.instance.initLevelSelection()
    }
    
    func tappedOptionsButton(button: SKButton) {
        println("Tapped options button.")
        var panel = OptionPanel(scene: self, size: CGSize(width: 600/2, height: 500/2), position: CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)))
        addChild(panel)
    }
    
    func tappedAboutButton(button: SKButton) {
        
        println("Tapped about button.")
        var panel = OptionPanel(scene: self, size: CGSize(width: 1058/2, height: 1058/2), position: CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)))
        addChild(panel)
    }
}