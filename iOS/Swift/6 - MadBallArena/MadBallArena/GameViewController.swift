//
//  GameViewController.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/20/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode
{
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

extension CGVector {
    // Get the length (a.k.a. magnitude) of the vector
    var length: CGFloat { return sqrt(self.dx * self.dx + self.dy * self.dy) }
    
    // Normalize the vector (preserve its direction, but change its magnitude to 1)
    var normalized: CGPoint { return CGPoint(x: self.dx / self.length, y: self.dy / self.length) }
}

class GameViewController: UIViewController
{
    static var instance: GameViewController!
    var mainView: SKView!
    var actualScene: GameScene!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainView = self.view as! SKView
        //mainView.showsFPS = true
        //mainView.showsNodeCount = true
        mainView.ignoresSiblingOrder = false
        
        GameViewController.instance = self
        self.initMenu()
    }

    override func shouldAutorotate() -> Bool
    {
        return true
    }

    override func supportedInterfaceOrientations() -> Int
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    // MENU
    func initMenu()
    {
        let scene = MenuScene(size: mainView.bounds.size)
        sceneTransition(scene)
    }
    
    // LEVEL SELECTION
    func initLevelSelection()
    {
        let scene = LevelSelectionScene(size: mainView.bounds.size)
        sceneTransition(scene)
    }
    
    func onBackLevelSelection()
    {
        initMenu()
    }
    
    // LEVEL
    func initLevel(data: LevelData)
    {
        let scene = LevelScene(data: data, size: mainView.bounds.size)
        sceneTransition(scene)
    }
    
    func onBackLevel()
    {
        initLevelSelection()
    }
    
    // TRANSITION
    func sceneTransition(newScene: GameScene)
    {
        actualScene = newScene
        mainView.presentScene(actualScene)
    }
}
