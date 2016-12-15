//
//  MovieTableViewCell.swift
//  ios-exam
//
//  Created by Martin Proks on 12/13/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "movieCell"
    
    var movieId = -1
    var index = -1
    
    var name: String? {
        didSet {
            textLabel?.text = name
        }
    }

    @IBOutlet weak var uiFavorite: UIButton!
    
    var favorite: Bool? {
        didSet {
            if (favorite == true) {
                uiFavorite.setImage(#imageLiteral(resourceName: "start-fill"), for: .normal)
            } else {
                uiFavorite.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            }
            uiFavorite.tag = self.index
        }
    }
    
}
