//
//  FileManager.swift
//  Bever
//
//  Created by Cristian Simioni Milani on 07/05/15.
//  Copyright (c) 2015 CWBCode. All rights reserved.
//

import Foundation

class FileManager {
    
    func moveFromBundleToDocuments(file: String) {
        let filePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent(file)
        var fileManager = NSFileManager.defaultManager()
        var fromPath: String? = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(file)
        if !fileManager.fileExistsAtPath(filePath) {
            fileManager.copyItemAtPath(fromPath!, toPath: filePath, error: nil)
        } else {
            println("File already exists at path: " + filePath)
        }
    }
    
    func createNewFileIntoDocuments(file: String) {
        let filePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent(file)
        var fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(filePath) {
            fileManager.createFileAtPath(filePath, contents: nil, attributes: nil)
        } else {
            println("File already existis at path: " + filePath)
        }
    }
    
    func getFileContent(file: String, from: Int) -> (String) {
        // 0 is from Bundle
        // 1 is from Documents
        
        let filePath: String!
        if from == 1 {
            filePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent(file)
        } else {
            filePath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(file)
        }
        
        // If the file does not exist, return nothing.
        var fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(filePath) {
            return ""
        }
        
        return String(contentsOfFile:filePath, encoding: NSUTF8StringEncoding, error: nil)!
    }
    
    
    func appendContent(file: String, append: String) {
        let filePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent(file)
        
        var fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            
            var url: NSURL = NSURL(fileURLWithPath: filePath)!
            
            var content: String = self.getFileContent(file, from: 1)
            content += append
            content.writeToURL(url, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        }
    }
    
    func getPathFileFromBundle(file: String) -> (String) {
        
        let filePath: String!
        filePath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(file)
        return filePath
    }
    
    func getPathFileFromDocuments(file: String) -> (String) {
        let filePath: String!
        filePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent(file)
        return filePath
    }
}