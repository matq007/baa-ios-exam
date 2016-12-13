//
//  MovieTableViewController.swift
//  ios-exam
//
//  Created by Martin Proks on 12/12/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, StateControllerDelegate {

    var stateController: StateController?
    
    func dataIsReady() {
        tableView.reloadData()
        
        tableView.estimatedRowHeight = 75.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stateController = stateController {
            return stateController.movies.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        if let movie = stateController?.movies[indexPath.row] {
            
            cell.textLabel?.text = movie.name
            // cell.detailTextLabel?.text = movie.category
            
            if movie.image == nil {
                // closure for download image
                // and set the repos image to the downloaded image
                
                if let imageURL = URL(string: movie.imageUrl) {
                    URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, URLResponse, error) in
                        
                        if error == nil {
                            if let data = data {
                                if let image = UIImage(data: data) {
                                    
                                    // update GUI on main thread
                                    DispatchQueue.main.async {
                                        cell.imageView?.image = image
                                        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                                    }
                                    // update the repo in statecontroller
                                    self.stateController?.updateMovieImage(index: indexPath.row, image: image)
                                }
                            }
                        }
                        
                    }).resume()
                }
                
            } else {
                // we have the image. No need to download again
                cell.imageView?.image = movie.image
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "infoSeg", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailViewController
        let index = sender as! Int
        detail.movie = stateController?.movies[index]
    }
    
}
