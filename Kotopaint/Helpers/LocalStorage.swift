//
//  LocalStorage.swift
//  DentalApp
//
//  Created by Loc on 4/4/17.
//  Copyright © 2017 ProStageVN. All rights reserved.
//

import SwiftyJSON

class LocalStorage: NSObject {
    
    // Properties
    static let sharedInstance = LocalStorage()
    private let fileName = "db"
    var content = JSON(NSNull())
    
    // Methods
    private func writeFile(_ text: String) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = documentDirectory.appendingPathComponent(fileName)
            print(path.absoluteString)
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func readFile() -> String {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = documentDirectory.appendingPathComponent(fileName)
            
            do {
                try FileManager.default.createDirectory(at: documentDirectory, withIntermediateDirectories: true, attributes: nil)
                return try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return ""
    }
    
    func setInt(_ data: Int, forKey: String) {
        content[forKey].int = data
        writeFile(content.description)
    }
    
    func getInt(forKey: String) -> Int {
        if content == JSON.null {
            return 0
        }
        
        return content[forKey].intValue
    }
    
    func setFloat(_ data: Float, forKey: String) {
        content[forKey].float = data
        writeFile(content.description)
    }
    
    func getFloat(forKey: String) -> Float {
        if content == JSON.null {
            return 0
        }
        
        return content[forKey].floatValue
    }
    
    func setString(_ data: String, forKey: String) {
        content[forKey].string = data
        writeFile(content.description)
    }
    
    func getString(forKey: String) -> String {
        if content == JSON.null {
            return ""
        }
        
        return content[forKey].stringValue
    }
    
    func setBool(_ data: Bool, forKey: String) {
        content[forKey].bool = data
        writeFile(content.description)
    }
    
    func getBool(forKey: String) -> Bool {
        if content == JSON.null {
            return false
        }
        
        return content[forKey].boolValue
    }
    
    func setJSON(_ data: JSON, forKey: String) {
        content[forKey] = data
        writeFile(content.description)
    }
    
    func update() {
        writeFile(content.description)
    }
    
    // Constructors
    override init() {
        super.init()
        
        let fileContent = readFile()
        content = JSON(parseJSON: fileContent)
        if content == JSON.null {
            content = [:]
        }
    }
}
