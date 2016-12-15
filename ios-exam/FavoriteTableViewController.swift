//
//  FavoriteTableViewController.swift
//  ios-exam
//
//  Created by Martin Proks on 12/12/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var stateController: StateController?
    var storage: Storage?
    var favorites: [Movie]?
    
    @IBAction func uiClearAll(_ sender: UIBarButtonItem) {
        self.stateController?.storage?.clear()
        self.favorites = []
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let stateController = stateController {
            favorites = stateController.movies.filter() {
                return (self.stateController?.storage?.exists(key: $0.id))!
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        tableView.estimatedRowHeight = 75.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let favorites = favorites {
            return favorites.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        if let movie = favorites?[indexPath.row] {
            
            cell.movieId = movie.id
            cell.index = indexPath.row
            cell.name = movie.name
            cell.favorite = true
            cell.imageView?.image = movie.image

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "info2Seg", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailViewController
        let index = sender as! Int
        
        detail.stateController = stateController
        detail.movieId = favorites?[index].id
    }
    
}
