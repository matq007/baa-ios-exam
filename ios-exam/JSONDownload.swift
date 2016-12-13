//
//  JSONDownload.swift
//  TopGitHub
//
//  Created by Kaj Schermer Didriksen on 03/11/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import Foundation


class JSONDownload {
    var delegate: JSONDownloadDelegate
    
    init(urlPath: String, delegate: JSONDownloadDelegate) {
        self.delegate = delegate
        
        if let endPoint = URL(string: urlPath) {
            let request = URLRequest(url: endPoint)
            
            URLSession.shared.dataTask(with: request, completionHandler: {
                
                // closure to run when dataTask is done
                // with or without error
                (data, response, error) in
                
                // it might throw error so do...
                do {
                    // can we unfold the data optional?
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    // use SwiftyJSON to serialize the raw bits in data
                    let json = JSON(data: data)
                    
                    // we are on a seperate thread/queu. 
                    // We are nice and call the delegate on the main queu
                    DispatchQueue.main.async {
                        delegate.finishedDownloadingJSON(data: json)
                    }
                    
                    
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }).resume()
            
        }
        
    }
    
}
