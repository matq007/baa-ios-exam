//
//  StateController.swift
//  ios-exam
//
//  Created by Martin Proks on 12/12/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

class StateController : JSONDownloadDelegate {

    var delegate: StateControllerDelegate?
    var storage: Storage?
    
    // setter is private, getter is public.
    // This way We can hide the implementation
    private(set) var movies = [Movie]()
    
    func add(movie: Movie) {
        movies.append(movie)
    }
    
    func setNotification(notify: String) {
    
    }
    
    func updateMovieImage(index: Int, image: UIImage) {
        movies[index].image = image
    }
    
    func getData() {
        _ = JSONDownload(urlPath: Config.ENDPOINT.rawValue, delegate: self)
        self.movies = []
    }
    
    func finishedDownloadingJSON(data: JSON) {
        if let items = data["feed"]["entry"].array {
            for item in items {
                if let id = item["id"]["attributes"]["im:id"].string,
                   let name = item["im:name"]["label"].string,
                   let title = item["title"]["label"].string,
                   let artist = item["im:artist"]["label"].string,
                   let summary = item["summary"]["label"].string,
                   let category = item["category"]["attributes"]["label"].string,
                   let tags = item["im:contentType"]["attributes"]["label"].string,
                   let duration = item["link"][1]["im:duration"]["label"].string,
                   let rights = item["rights"]["label"].string,
                   let link = item["link"][0]["attributes"]["href"].string,
                   let rentalPrice = item["im:rentalPrice"]["attributes"]["amount"].string,
                   let currency = item["im:rentalPrice"]["attributes"]["currency"].string,
                   let price = item["im:price"]["attributes"]["amount"].string,
                   let releaseDate = item["im:releaseDate"]["label"].string,
                   let imageUrl = item["im:image"][2]["label"].string {
                    let movie = Movie(id: id, name: name, title: title, artist: artist, summary: summary,
                                      category: category, tags: tags, duration: duration, rights: rights, link: link,
                                      rentalPrice: rentalPrice, price: price, currency: currency, releaseDate: releaseDate, imageUrl: imageUrl)
                    self.add(movie: movie)
                }
                
            }
        }
        
        delegate?.dataIsReady()
    }
    
}
