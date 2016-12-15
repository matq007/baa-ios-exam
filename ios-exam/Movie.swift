//
//  Movie.swift
//  ios-exam
//
//  Created by Martin Proks on 12/11/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

struct Movie {

    let id: Int
    let name: String
    let title: String
    let artist: String
    let summary: String
    let category: String
    let tags: String
    let duration: Double
    let rights: String
    let link: String
    
    let rentalPrice: Double
    let price: Double
    let currency: String
    
    let releaseDate: Date?
    var imageUrl: String
    var image: UIImage?
    
    init(id: String, name: String, title: String, artist: String, summary: String,
         category: String, tags: String, duration: String, rights: String, link: String,
         rentalPrice: String, price: String, currency: String, releaseDate: String, imageUrl: String) {
    
        self.id = Int(id)!
        self.name = name
        self.title = title
        self.artist = artist
        self.summary = summary
        self.category = category
        self.tags = tags
        self.duration = Double(duration)!
        self.rights = rights
        self.link = link
        
        self.rentalPrice = Double(rentalPrice)!
        self.price = Double(price)!
        self.currency = currency
        
        let tmp = DateFormatter()
        tmp.dateFormat = Config.DATE_FORMAT.rawValue
        self.releaseDate = tmp.date(from: releaseDate)
        
        self.imageUrl = imageUrl
        self.image = nil
    }
    
}
