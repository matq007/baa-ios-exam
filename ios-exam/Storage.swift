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
    
    func exists(key: String) -> Bool {
        if (storage.string(forKey: key) != nil) {
            return true
        }
        
        return false
    }
    
    func set(key: String) -> Void{
        self.storage.set(true, forKey: key)
    }
    
    func delete(key: String) -> Void {
        self.storage.removeObject(forKey: key)
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
