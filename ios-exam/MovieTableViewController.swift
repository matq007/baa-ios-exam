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
    var rerfreshCtrl: UIRefreshControl!
    
    @IBOutlet weak var uiLastUpdated: UINavigationItem!
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        self.rerfreshCtrl = UIRefreshControl()
        self.rerfreshCtrl.addTarget(self, action: #selector(MovieTableViewController.refreshTableView) , for: .valueChanged)
        self.refreshControl = self.rerfreshCtrl
        
        refreshTableView()
    }
    
    func refreshTableView() {
        stateController?.getData()
        stateController?.delegate = self
    }
    
    func dataIsReady() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = Config.HUMAN_DATE_FORMAT.rawValue
        
        let updateString = "Last Updated at " + dateFormatter.string(from: currentDate)
    
        self.uiLastUpdated.title = updateString
        self.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    @IBAction func uiFavoriteToggle(_ sender: UIButton) {

        if (sender.tag != -1) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell! {
                if (cell.favorite == true) {
                    cell.favorite = false
                    self.stateController?.storage?.delete(key: String(cell.movieId))
                } else {
                    cell.favorite = true
                    self.stateController?.storage?.set(key: String(cell.movieId))
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stateController = stateController {
            return stateController.movies.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        if let movie = stateController?.movies[indexPath.row] {
            
            cell.movieId = movie.id
            cell.index = indexPath.row
            cell.name = movie.name
            cell.favorite = self.stateController?.storage?.exists(key: String(movie.id))
            
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
        
        detail.stateController = stateController
        detail.movieId = stateController?.movies[index].id
    }
    
}
