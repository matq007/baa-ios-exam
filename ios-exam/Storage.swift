//
//  Storage.swift
//  ios-exam
//
//  Created by Martin Proks on 12/13/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import Foundation

class Storage {
    
    let storage = UserDefaults.standard
    
    func exists(key: Int) -> Bool {
        if (storage.string(forKey: String(key)) != nil) {
            return true
        }
        
        return false
    }
    
    func add(key: Int) -> Void{
        self.storage.set(true, forKey: String(key))
    }
    
    func remove(key: Int) -> Void {
        self.storage.removeObject(forKey: String(key))
    }
    
    func clear() -> Void {
        for key in self.storage.dictionaryRepresentation().keys {
            self.storage.removeObject(forKey: key.description)
        }
    }
    
    func getKeys() -> LazyMapCollection<Dictionary<String, Any>, String> {
        return self.storage.dictionaryRepresentation().keys
    }
    
}
