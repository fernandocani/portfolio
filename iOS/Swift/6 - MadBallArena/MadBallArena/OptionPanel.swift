//
//  OptionPanel.swift
//  MadBallArena
//
//  Created by Cristian Simioni Milani on 25/05/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

class OptionPanel: SKPanel {
    
    override init (scene: SKScene, size: CGSize, position: CGPoint) {
        super.init(scene: scene, size: size, position: position)
        self.loadTitleContent()
        self.loadContent()
        self.loadActionsContent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadTitleContent() {
        setBackgroundColorOfTitle(UIColor.whiteColor())
        setTitle("Options")
    }
    
    private func loadContent() {
        
    }
    
    private func loadActionsContent() {
        setBackgroundColorOfActions(UIColor.whiteColor())
        
        var close = SKButton(normalImageNamed: "close", highlightedImageNamed: "close", disabledImageNamed: "close", size: CGSize(width: 50, height: 50), buttonFunc: nil)
        close.position = CGPointMake(_action!.size.width/2 - 40, 0)
        _action!.addChild(close)
    }
}