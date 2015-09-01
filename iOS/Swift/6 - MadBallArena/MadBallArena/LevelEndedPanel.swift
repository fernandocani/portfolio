//
//  LevelEndedPanel.swift
//  MadBallArena
//
//  Created by Fernando Cani on 5/29/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

class LevelEndedPanel: SKPanel {
    
    internal var stars: Stars!
    internal var dataNow: LevelData!
    internal var dataActualLevel: LevelData!
    
    init (dataNow: LevelData, dataActualLevel: LevelData, scene: SKScene, size: CGSize, position: CGPoint)
    {
        self.dataNow = dataNow
        self.dataActualLevel = dataActualLevel
        super.init(scene: scene, size: size, position: position)
        self.loadTitleContent()
        self.loadContent()
        self.loadActionsContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadTitleContent() {
        self.setBackgroundColorOfTitle(UIColor.clearColor())
        if dataNow.time > 0.0 {
            self.setTitle("Winner !")
        } else {
            self.setTitle("Loser !")
        }
        _close.removeFromParent()
    }
    
    private func loadContent() {
        self.setBackgroundColorOfContent(UIColor.clearColor())
        self.starsSet()
        self.timeSet()
    }
    
    private func timeSet() {
        var title = SKSpriteNode(   color: UIColor.clearColor(),
                                    size: CGSize(   width: _content!.size.width,
                                                    height: 100))
        title.position = CGPoint(   x: 0,
                                    y: 50)
        _content!.addChild(title)
        
        var titleLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        titleLabel.text = "Tempo restante: \(dataNow.time!.description)"
        titleLabel.fontSize = 35
        titleLabel.fontColor = UIColor.whiteColor()
        title.addChild(titleLabel)
    }
    
    private func starsSet() {
        stars = Stars(size: CGSizeMake( self.frame.width * 0.8,
                                        self.frame.height * 0.25))
        stars.position = CGPointMake(   0,
                                        -(self.frame.height/2 * 0.50))
        stars.setScore(dataNow.score)
        _content!.addChild(stars)
    }
    
    private func loadActionsContent() {
        setBackgroundColorOfActions(UIColor.clearColor())
        self.menuButton()
        self.replayButton()
        if self.dataNow.nextLevelData != nil {
            self.nextButton()
        }
    }
    
    private func menuButton() {
        var menu = SKButton(    normalImageNamed:       "btnMenu",
                                highlightedImageNamed:  "btnMenu",
                                disabledImageNamed:     "btnMenu",
                                size: CGSize(   width: 50,
                                                height: 50),
                                buttonFunc: tappedMenuButton)
        menu.position = CGPointMake(0-_action!.size.width/3.5,0)
        _action!.addChild(menu)
    }
    
    private func tappedMenuButton(button: SKButton)
    {
        tappedCloseButton(nil)
        GameViewController.instance.initLevelSelection()
    }
    
    private func replayButton() {
        var replay = SKButton(  normalImageNamed:       "btnReplay",
                                highlightedImageNamed:  "btnReplay",
                                disabledImageNamed:     "btnReplay",
                                size: CGSize(   width: 50,
                                                height: 50),
                                buttonFunc: tappedReplayButton)
        replay.position = CGPointMake(0,0)
        _action!.addChild(replay)
    }
    
    private func tappedReplayButton(button: SKButton)
    {
        tappedCloseButton(nil)
        if self.dataActualLevel != nil {
            GameViewController.instance.initLevel(self.dataActualLevel)
        }
    }
    
    private func nextButton() {
        var next = SKButton(normalImageNamed:       "btnNext",
                            highlightedImageNamed:  "btnNext",
                            disabledImageNamed:     "btnNext",
                            size: CGSize(   width: 50,
                                            height: 50),
                            buttonFunc: tappedNextButton)
        next.position = CGPointMake(_action!.size.width/3.5, 0)
        _action!.addChild(next)
    }
    
    private func tappedNextButton(button: SKButton)
    {
        tappedCloseButton(nil)
        if self.dataNow.nextLevelData != nil {
            GameViewController.instance.initLevel(self.dataNow.nextLevelData)
        }
    }
}