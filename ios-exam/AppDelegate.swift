//
//  AppDelegate.swift
//  ios-exam
//
//  Created by Martin Proks on 12/11/16.
//  Copyright © 2016 Martin Proks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var stateController = StateController()
    var storage = Storage()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
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


}

