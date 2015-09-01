//
//  LevelStore.swift
//  MadBallArena
//
//  Created by Cristian Simioni Milani on 26/05/15.
//  Copyright (c) 2015 Victor Georg. All rights reserved.
//

import Foundation
import SpriteKit

private let _LevelStoreSharedInstance = LevelStore()

class LevelStore {
    static let sharedInstance = LevelStore()
    internal var levelList = [LevelData]()
    
    
    func add(level: LevelData) {
        levelList.append(level)
    }
    
    func count() -> (Int) {
        return levelList.count
    }
    
    func getLevelByIndex(index: Int) -> (LevelData) {
        return levelList[index]
    }
    
    func getCollection() -> ([LevelData]) {
        return levelList
    }
    
    func loadData () {
        // Insert data into level list
        
        let levelsData = NSData(contentsOfFile: FileManager().getPathFileFromBundle("Levels.json"), options: NSDataReadingOptions.DataReadingMapped, error: nil)
        let levelsDictionary = NSJSONSerialization.JSONObjectWithData(levelsData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        var scoresData = NSData(contentsOfFile: FileManager().getPathFileFromDocuments("Scores.json"), options: NSDataReadingOptions.DataReadingMapped, error: nil)
        var scoresDictionary = NSJSONSerialization.JSONObjectWithData(scoresData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        var i: Int = 0
        for currentLevel in levelsDictionary["levels"] as! NSArray {
            
            let currentLevelData = NSData(contentsOfFile: FileManager().getPathFileFromBundle(currentLevel as! String), options: NSDataReadingOptions.DataReadingMapped, error: nil)
            let currentLevelDictionary = NSJSONSerialization.JSONObjectWithData(currentLevelData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Dictionary<String, AnyObject>
            
            var point = CGPoint()
            if let arrayForce = currentLevelDictionary["initVector"] as? Array<CGFloat> {
                point.x = arrayForce[0]
                point.y = arrayForce[1]
            }
            
            var level: LevelData = LevelData(_id: currentLevelDictionary["id"] as! Int, _level: currentLevelDictionary["level"] as! Int, _score: scoresDictionary["\(i + 1)"] as! Int, time: 0.0, initialVector: point)
            level.description = currentLevelDictionary["description"] as? String
            level.name = currentLevelDictionary["name"] as? String
            level.thumbImage = currentLevelDictionary["thumbImage"] as? String
            level.backgroundImage = currentLevelDictionary["backgroundImage"] as? String
            level.time = currentLevelDictionary["time"] as? Float
            
            
            var walls = currentLevelDictionary["walls"] as! NSArray
            for wall in walls {
                var newWall = Wall()
                for point in wall as! NSArray {
                    newWall.addPoints(CGPoint(x: point[0] as! Double, y: point[1] as! Double))
                }
                level.walls.append(newWall)
            }
            
            levelList.append(level)
            i++
        }
    }
    
    func updateScore(level: Int, score: Int) {
        // Update current memory
        levelList[level-1].score = score
        
        // Update file (Score.json)
        let scoresData = NSData(contentsOfFile: FileManager().getPathFileFromDocuments("Scores.json"), options: NSDataReadingOptions.DataReadingMapped, error: nil)
        let scoresDictionary = NSJSONSerialization.JSONObjectWithData(scoresData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        scoresDictionary.setValue(score, forKey: "\(level)")
        
        let options = NSJSONWritingOptions.PrettyPrinted
        var outputData : NSData? =  NSJSONSerialization.dataWithJSONObject(scoresDictionary, options: options, error: nil)
        
        outputData?.writeToFile(FileManager().getPathFileFromDocuments("Scores.json"), atomically: true)
    }
    
}
