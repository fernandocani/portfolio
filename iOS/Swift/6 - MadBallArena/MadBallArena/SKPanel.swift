//
//  SKPanel.swift
//  MadBallArena
//
//  Created by Cristian Simioni Milani on 22/05/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

class SKPanel: SKSpriteNode {
    
    /*
    * Assign to name for convernient debug / work
    */
    let panelName = "SKPanel"
    
    /*
    * Convernient tag
    */
    var tag: Int = 0
    
    /*
    * Function to be called after being tapped
    */
    var buttonFunc: ((button: SKButton) -> Void)?
    
    /*
    * Internal data, should not be accessed from outside
    */
    private var _size: CGSize?
    private var _position: CGPoint?
    private var _blur: SKSpriteNode?
    internal var _title: SKSpriteNode?
    internal var _titleLabel: SKLabelNode?
    internal var _content: SKSpriteNode?
    internal var _action: SKSpriteNode?
    internal var _close: SKButton!
    
    /*
    * Init
    */
    init (scene: SKScene, size: CGSize, position: CGPoint) {
        let generatedImageTexture = SKTexture(imageNamed: "background")
        
        _size = size
        _position = position
        
        super.init(texture: nil, color: UIColor.clearColor(), size: generatedImageTexture.size())
        
        // Apply blur in the main scene
        _blur = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 2058, height: 1058))
        _blur!.alpha = 0.7
        _blur!.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame))
        scene.addChild(_blur!)
        
        // Panel
        var panel = SKSpriteNode(texture: generatedImageTexture, color: UIColor.clearColor(), size: size)
        panel.color = UIColor.blackColor()
        panel.position = position
        self.addChild(panel)
        
        // Title panel
        // Height size: 10% of panel size
        _title = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: _size!.width, height: _size!.height * 0.10))
        _title!.position = CGPoint(x: _position!.x, y: _position!.y + (_size!.height/2) - ((_size!.height * 0.35)/2))
        self.addChild(_title!)
        
        _titleLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        _titleLabel!.text = "Title"
        _titleLabel!.fontSize = 50
        _titleLabel!.fontColor = UIColor.whiteColor()
        _title!.addChild(_titleLabel!)
        
        
        // Content panel
        // Height size: 80% of panel size
        _content = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: _size!.width, height: _size!.height * 0.80))
        _content!.position = _position!
        self.addChild(_content!)
        
        // Action panel
        // Height size: 10% of panel size
        _action = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: _size!.width, height: _size!.height * 0.10))
        _action!.position = CGPoint(x: _position!.x, y: _position!.y - (_size!.height/2) + ((_size!.height * 0.15)/2))
        self.addChild(_action!)
        
        // Close button
        _close = SKButton(normalImageNamed: "close", highlightedImageNamed: "close", disabledImageNamed: "close", size: CGSize(width: 50, height: 50), buttonFunc: tappedCloseButton)
        _close.position = CGPointMake(position.x + (size.width/2) - 10, position.y + (size.height/2) - 10)
        self.addChild(_close)
        
    }
    
    /*
    * Private Methods
    */
    internal func tappedCloseButton(button: SKButton!)
    {
        _blur?.removeFromParent()
        _title?.removeAllChildren()
        _content?.removeAllChildren()
        _action?.removeAllChildren()
        self.removeAllChildren()
        println("Tapped close button.")
    }
    
    /*
    * Public Methods
    */
    func setBackgroundColorOfTitle(color: UIColor) {
        _title?.color = color
    }
    
    func setBackgroundColorOfContent(color: UIColor) {
        _content?.color = color
    }
    
    func setBackgroundColorOfActions(color: UIColor) {
        _action?.color = color
    }
    
    func setTitle(title: String) {
        _titleLabel?.text = title
    }

    /*
    * Needed to stop XCode warnings
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
