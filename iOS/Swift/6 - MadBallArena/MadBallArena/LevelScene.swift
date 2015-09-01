//
//  LevelScene.swift
//  MadBallArena
//
//  Created by Victor Georg on 5/22/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import SpriteKit

class LevelScene: GameScene, SKPhysicsContactDelegate
{
    private static let RUNNING: Int = 0
    private static let FINISHED: Int = 1
    
    internal var data:                  LevelData
    internal var ball:                  Ball!
    internal var hole:                  Hole!
    internal var square:                Mirror!
    internal var mirrorAux:             Mirror! = nil
    internal var startMirrorPoint:      CGPoint! = nil
    internal var endMirrorPoint:        CGPoint! = nil
    internal var distanceX:             CGFloat!
    internal var distanceY:             CGFloat!
    internal var time:                  Float!
    internal var timeLabel:             SKLabelNode!
    private let kTimeoutInSeconds:NSTimeInterval = 1
    internal var timer: NSTimer!
    internal var state:                 Int
    
    init(data: LevelData, size: CGSize)
    {
        self.data = data
        time = data.time
        self.state = LevelScene.RUNNING
        super.init(size: size)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(kTimeoutInSeconds, target:self, selector:Selector("fetch"), userInfo:nil, repeats:true)
    }
    
    func fetch() {
        time = time - 1.0;
        timeLabel.text = time.description
        if time <= 0.0 {
            self.timer!.invalidate()
            self.objectiveCompleted(hole)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
    }
    
    override internal func loadComponents()
    {
        background = SKSpriteNode(imageNamed: self.data.backgroundImage)
        background.size = self.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(background)
        
        // Shade
        var shade = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 2058, height: 1058))
        shade.alpha = 0.7
        shade.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(shade)
        
        // Stars
        var stars = Stars(size: CGSizeMake(self.frame.width * 0.15, self.frame.height * 0.5))
        stars.position = CGPointMake(self.frame.width * 0.08, self.frame.height * 0.95)
        stars.setScore(data.score)
        self.addChild(stars)
        
        // Time
        timeLabel = SKLabelNode(text: time.description)
        timeLabel.fontSize = 50
        timeLabel.fontName = "AmericanTypewriter-Bold"
        timeLabel.position = CGPointMake(self.frame.width * 0.93, self.frame.height * 0.93)
        self.addChild(timeLabel)
        
        // Ball
        createBall()
        
        // Hole
        createHole()
        
        // Draw walls
        var offsetX = self.frame.size.width * self.anchorPoint.x;
        var offsetY = self.frame.size.height * self.anchorPoint.y;
        
        for wall in data.walls {
            println("Wall: ")
            var i: Int = 0
            var path:CGMutablePathRef = CGPathCreateMutable()
            var myLine:SKShapeNode = SKShapeNode(path:path)
            for point in wall.points {
                if i == 0 {
                    CGPathMoveToPoint(path, nil, 59 - offsetX, 284 - offsetY);
                } else {
                    CGPathAddLineToPoint(path, nil, 262 - offsetX, 272 - offsetY);
                    CGPathAddLineToPoint(path, nil, 270 - offsetX, 89 - offsetY);
                }
                i++
                println(point.x)
                println(point.y)
            }
            
            myLine.path = path
            myLine.strokeColor = SKColor.whiteColor()
            
            myLine.fillColor = UIColor.whiteColor()
            myLine.alpha = 0.6
            
            myLine.physicsBody = SKPhysicsBody(polygonFromPath: path)
            myLine.physicsBody!.dynamic = false
            myLine.physicsBody!.allowsRotation = false
            
            CGPathCloseSubpath(path)
            
            self.addChild(myLine)
        }
        
        self.createScreenLimits()
    }
    
    func createBall()
    {
        ball = NormalBall()
        ball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(ball)
        ball.setImpulse(CGVectorMake(self.data.initialVector.x, self.data.initialVector.y))
    }
    
    func createHole()
    {
        hole = NormalHole()
        
        var normalW = hole.size.width
        var resizedW = self.frame.width * 0.08
        var r = normalW / resizedW
        
        hole.size = CGSizeMake(resizedW, hole.size.height / r)
        hole.position = CGPointMake(CGRectGetMidX(self.frame), hole.size.height - 20)
        
        hole.updatePhysics()
        self.addChild(hole)
    }
    
    func createScreenLimits() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.backgroundColor = SKColor.whiteColor()
        self.physicsBody!.friction = 0.0
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if self.state == LevelScene.FINISHED {
            return
        }
        super.touchesBegan(touches, withEvent: event)
        
        let touch = (touches as! Set<UITouch>).first
        let location = touch!.locationInNode(self)
        
        if mirrorAux != nil {
            return
        }
        
        startMirrorPoint = CGPointMake(location.x, location.y)
        mirrorAux = NormalMirror()
        mirrorAux.position = startMirrorPoint
        
        self.addChild(mirrorAux)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if self.state == LevelScene.FINISHED {
            return
        }
        super.touchesMoved(touches, withEvent: event)
        
        let touch = (touches as! Set<UITouch>).first
        let location = touch!.locationInNode(self)
        
        if startMirrorPoint == nil || mirrorAux == nil {
            return
        }
        
        endMirrorPoint = CGPointMake(location.x, location.y)
        let deltaX = endMirrorPoint.x - startMirrorPoint.x
        let deltaY = endMirrorPoint.y - startMirrorPoint.y
        let angleInDegrees:CGFloat = atan2(deltaY, deltaX) * 180 / 3.1416
        let wallZRotation = CGFloat(GLKMathDegreesToRadians(Float(angleInDegrees)))
        
        var distance = CGFloat(hypotf(Float(deltaX), Float(deltaY)))
        if distance > 200.0 {
            distance = 200.0
        }
        
        mirrorAux.runAction(SKAction.sequence([
            SKAction.resizeToWidth(distance, duration: 0),
            SKAction.rotateToAngle(wallZRotation, duration: 0)
            ]))
        mirrorAux.validateFactor()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if self.state == LevelScene.FINISHED {
            return
        }
        super.touchesEnded(touches, withEvent: event)
        
        let touch = (touches as! Set<UITouch>).first
        let location = touch!.locationInNode(self)
        
        if mirrorAux == nil {
            return
        }
        
        if mirrorAux.size.width >= Constants.mirrorMinSize
        {
            mirrorAux.build()
        }
        else
        {
            mirrorAux.removeFromParent()
        }
        startMirrorPoint = nil
        endMirrorPoint = nil
        mirrorAux = nil
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        if contact.bodyA.node!.isKindOfClass(LevelScene) || contact.bodyB.node!.isKindOfClass(LevelScene) || self.state == LevelScene.FINISHED || contact.bodyA.node!.isKindOfClass(SKShapeNode) || contact.bodyB.node!.isKindOfClass(SKShapeNode) {
            return
        }
        
        let firstNode = contact.bodyA.node as! GameObject
        let secondNode = contact.bodyB.node as! GameObject
        
        firstNode.onCollision(secondNode)
        secondNode.onCollision(firstNode)
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        super.update(currentTime)
    }
    
    func objectiveCompleted(hole: Hole)
    {
        self.state = LevelScene.FINISHED
        timer.invalidate()
        ball.removeFromParent()
        
        
        
        if (time > 0 && calculateScore() > self.data.score) {
            LevelStore.sharedInstance.updateScore(self.data.level, score: calculateScore())
        }
        
        let data = LevelData(   _id: self.data.id,
                                _level: self.data.level,
                                _score: calculateScore(),
                                time: self.time,
                                initialVector: self.data.initialVector)
        data.nextLevelData = self.data.nextLevelData
        let panel = LevelEndedPanel(dataNow: data,
                                    dataActualLevel: self.data,
                                    scene: self,
                                    size: CGSizeMake(   self.size.width * 0.4,
                                                        self.size.height * 0.70),
                                    position: CGPoint(  x: CGRectGetMidX(self.frame),
                                                        y: CGRectGetMidY(self.frame)))
        self.addChild(panel)
    }
    
    func calculateScore() -> (Int) {
        if time > 0 {
            if (((self.data.time! / 3) * 2) < self.time ) {
                return 3
            } else if (((self.data.time! / 3) * 2) > self.time && self.time > (self.data.time! / 3)) {
                return 2
            }   else {
                return 1
            }
        } else {
            return 0
        }
    }
}