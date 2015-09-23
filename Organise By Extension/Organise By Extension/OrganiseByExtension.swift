//
//  OrganiseByExtension.swift
//  Organise By Extension
//
//  Created by Mannie Tagarira on 10/06/2015.
//  Copyright (c) 2015 Mannie Tagarira. All rights reserved.
//

import Automator
import TAGToolbox

class OrganiseByExtension: AMBundleAction {
    
    override func runWithInput(input: AnyObject?) throws -> AnyObject {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let fileManager = NSFileManager.defaultManager()
        for sourcePath in inputFilePaths {
            let fileExt = sourcePath.pathExtension
            if fileExt.isEmpty {
                outputFilePaths.insert(sourcePath)
                continue
            }

            let parentDirectory = sourcePath.stringByDeletingLastPathComponent
            let organisedFiles = fileManager.organiseDirectoryAtPath(parentDirectory, withExtension: fileExt)
            outputFilePaths.unionInPlace(organisedFiles)
        }
        
        deliverUserNotification(Array<String>(outputFilePaths))

        return outputFilePaths
    }
    
}
