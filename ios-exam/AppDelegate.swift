//
//  AppDelegate.swift
//  ios-exam
//
//  Created by Martin Proks on 12/11/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var stateController = StateController()
    var storage = Storage()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        // Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        stateController.storage = storage
        if let tabbarController = window?.rootViewController as? UITabBarController {
        
            if let tabbar = tabbarController.viewControllers?[0] as? UINavigationController,
               let movieView = tabbar.viewControllers.first as? MovieTableViewController {
                movieView.stateController = stateController
            }
            
            if let tabbar = tabbarController.viewControllers?[1] as? UINavigationController,
                let favoriteView = tabbar.viewControllers.first as? FavoriteTableViewController {
                favoriteView.stateController = stateController
            }

        }
        return true
    }
    
    func scheduleNotification(at date: Date, title: String, body: String) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }


}

