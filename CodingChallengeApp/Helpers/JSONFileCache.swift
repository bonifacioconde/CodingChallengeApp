//
//  JSONFileCache.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class JSONFileCache {
    var filename = ""
    var documentsDirectoryPathString: String = ""
    var documentsDirectoryPath: URL!
    var jsonFilePath: URL?
    
    public init(name: String){
        self.filename = name.replacingOccurrences(of: "/", with: "_").appending(".json")
        documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
        let fileUrl = URL(string: self.filename)
        
        jsonFilePath = documentsDirectoryPath.appendingPathComponent((fileUrl?.absoluteString)!)
    }
    
    public func write(json: JSON, update: Bool = false) {
        debugPrint("JSONFileCache.write()")
        debugPrint(jsonFilePath!.absoluteString)
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: jsonFilePath!.absoluteString) {
            let created = fileManager.createFile(atPath: jsonFilePath!.absoluteString, contents: nil, attributes: nil)
            debugPrint("FileCreated: \(created)")
        } else {
            if update {
                do{
                    try fileManager.removeItem(atPath: jsonFilePath!.absoluteString)
                    let created = fileManager.createFile(atPath: jsonFilePath!.absoluteString, contents: nil, attributes: nil)
                    debugPrint("FileCreated: \(created)")
                }catch let error {
                    debugPrint("error occurred, here are the details:\n \(error)")
                }
            } else {
                debugPrint("File already exists")
            }
            
        }
        
        let str = json.description
        let data = str.data(using: String.Encoding.utf8)!
        guard let file = FileHandle(forWritingAtPath:jsonFilePath!.absoluteString) else {
            debugPrint("no file handle")
            return
        }
        debugPrint("has file handle: writing")
        file.write(data)
        
    }
    
    public func read(_ noTimeDiff: Bool = false) -> Data? {
        if let file = FileHandle(forReadingAtPath: jsonFilePath!.absoluteString){
            return file.readDataToEndOfFile()
        }else{
            debugPrint("Error Reading from \(String(describing: jsonFilePath?.absoluteString))")
        }
        
        return nil
    }
    
    public func getfileCreatedDate() -> Date {
        var theCreationDate = Date()
        do{
            let aFileAttributes = try FileManager.default.attributesOfItem(atPath: self.jsonFilePath?.absoluteString ?? "") as [FileAttributeKey:Any]
            theCreationDate = aFileAttributes[FileAttributeKey.creationDate] as! Date
            
        } catch let theError {
            debugPrint("file not found \(theError)")
        }
        return theCreationDate
    }
    
    public func clear() -> Void {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: jsonFilePath!.absoluteString)
            debugPrint("Removed: \(String(describing: jsonFilePath!.absoluteString))")
        }catch let error as NSError {
            debugPrint("Ooops! Something went wrong: \(error)")
        }
        
    }
}
