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
    var movieId: Int?
    var movie: Movie?
    
    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var uiDuration: UILabel!
    @IBOutlet weak var uiArtist: UILabel!
    @IBOutlet weak var uiCategory: UILabel!
    @IBOutlet weak var uiTag: UILabel!
    @IBOutlet weak var uiRentalPrice: UILabel!
    @IBOutlet weak var uiPrice: UILabel!
    @IBOutlet weak var uiTitle: UINavigationItem!
    @IBOutlet weak var uiSummary: UITextView!
    @IBOutlet weak var uiDatePickerText: UITextField!
    
    @IBAction func uiLink(_ sender: UIButton) {
        if let link = self.movie?.link, let url = NSURL(string: link) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        
        if let movieId = movieId,
           let stateController = stateController {
            self.movie = stateController.movies.filter{ $0.id == movieId }.first
        }
        
        if let title = self.movie?.title,
           let artist = self.movie?.artist,
           let category = self.movie?.category,
           let tag = self.movie?.tags,
           let duration = self.movie?.duration,
           let poster = self.movie?.image,
           let rentalPrice = self.movie?.rentalPrice,
           let price = self.movie?.price,
           let currency = self.movie?.currency,
           let summary = self.movie?.summary {
            self.uiTitle.title = title
            self.uiArtist.text = "Artist:\n\(artist)"
            self.uiCategory.text = "Category:\n\(category)"
            self.uiTag.text = "Tags:\n\(tag)"
            self.uiImage.image = poster
            self.uiRentalPrice.text = "Rental price: \(rentalPrice) \(currency)"
            self.uiPrice.text = "Normal price: \(price) \(currency)"
            self.uiDuration.text = "Duration: \(duration)"
            self.uiSummary.text = summary
        }
    }
    
    @IBAction func uiDatePicker(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        datePicker.addTarget(self, action: #selector(DetailViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        sender.inputView = datePicker
        sender.inputAccessoryView = toolBar
    }
    
    func doneDatePicker(sender: UIButton) {
        uiDatePickerText.resignFirstResponder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.HUMAN_DATE_FORMAT.rawValue
        
        let selectedDate = dateFormatter.date(from: uiDatePickerText.text!)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let name = movie?.name {
            let title = "iOS Exam Notification"
            let body = "You have a notification from \(name)"
            delegate?.scheduleNotification(at: selectedDate!, title: title, body: body)
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.HUMAN_DATE_FORMAT.rawValue
        uiDatePickerText.text = dateFormatter.string(from: sender.date)
    }
    
}
