//
//  PersistHelper.swift
//  EmojiJSONTranslator
//
//  Created by Paul Wood on 11/4/16.
//
//

import Foundation

public enum FileSaverError: Error {
    case fileExists
    case dataExist
    case JSONParseError
    case JSONContentError
}



public class FileSaver {
    struct Directories {
        let currentWorking = "./"
    }
    let fileManager = FileManager.default
    
/*
    func saveJSONArray(array arr : [Any], filename:String) throws {

    }
    
    func saveJSONDictionary(array arr : [String:Any], filename:String) throws {
        
    }
    
    func loadJSONArray(filename : String) throws -> [Any] {
        
    }
*/
    /// Filename should be a path relative to the package folder
    func loadJSONDictionary(filename : String) throws -> [String:Any] {
        let sourceFolderURL = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
        let path = URL(fileURLWithPath: filename, relativeTo: sourceFolderURL)
        
        guard fileManager.fileExists(atPath:path.absoluteString) else {
            throw FileSaverError.fileExists
        }
        do {
            let data = try? Data(contentsOf: path)
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            guard let emojiDict = json as? [String: Any] else {
                throw FileSaverError.JSONContentError
            }
            return emojiDict
            
        } catch {
            throw error
        }
        
        /*
        guard FileManager.default.fileExists(atPath:path),
            let url = URL(string: path) else {
                throw FileSaverError.fileExists
        }
        guard let data = try? Data(contentsOf: url) else {
            throw FileSaverError.dataExist
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            throw FileSaverError.JSONParseError
        }
        guard let emojiDict = json as? [String: Any] else {
            throw FileSaverError.JSONContentError
        }
        return emojiDict
         */
    }
    
}
