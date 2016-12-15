//
//  Config.swift
//  ios-exam
//
//  Created by Martin Proks on 12/11/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import Foundation

enum Config: String {
    case ENDPOINT = "https://itunes.apple.com/dk/rss/topmovies/limit=100/json"
    case DATE_FORMAT = "yyyy-MM-dd'T'hh:mm:ssZ"
    case HUMAN_DATE_FORMAT = "yyyy-dd-MM HH:mm:ss"
}

enum JSONError: String, Error {
    case NoData = "Error: No Data!"
    case Convertionfailed = "Error: Convertion from JSON Failed!"
}
