//
//  DetailViewController.swift
//  ios-exam
//
//  Created by Martin Proks on 12/12/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    var stateController: StateController?
    var movie: Movie?
    
    @IBOutlet weak var uiImage: UIImageView!
    
    @IBOutlet weak var uiDuration: UILabel!
    @IBOutlet weak var uiArtist: UILabel!
    @IBOutlet weak var uiCategory: UILabel!
    @IBOutlet weak var uiTag: UILabel!
    @IBOutlet weak var uiRentalPrice: UILabel!
    @IBOutlet weak var uiPrice: UILabel!
    @IBOutlet weak var uiSummary: UIScrollView!
    @IBOutlet weak var uiTitle: UINavigationItem!
    
    @IBAction func uiLink(_ sender: UIButton) {
        if let link = self.movie?.link, let url = NSURL(string: link) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        
        if let title = self.movie?.title,
           let artist = self.movie?.artist,
           let category = self.movie?.category,
           let tag = self.movie?.tags,
           let duration = self.movie?.duration,
           let poster = self.movie?.image,
           let rentalPrice = self.movie?.rentalPrice,
           let price = self.movie?.price,
            let currency = self.movie?.currency {
           //let summary = self.movie?.summary {
            self.uiTitle.title = title
            self.uiArtist.text = "Artist:\n\(artist)"
            self.uiCategory.text = "Categoryist:\n\(category)"
            self.uiTag.text = "Tags:\n\(tag)"
            self.uiImage.image = poster
            self.uiRentalPrice.text = "Rental price: \(rentalPrice) \(currency)"
            self.uiPrice.text = "Normal price: \(price) \(currency)"
            self.uiDuration.text = "Duration: \(duration)"
        }
        
    }
}
