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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let tabbarController = window?.rootViewController as? UITabBarController {
        
            stateController.getData()
            
            if let tabbar = tabbarController.viewControllers?[0] as? UINavigationController,
               let movieView = tabbar.viewControllers.first as? MovieTableViewController {
                movieView.stateController = stateController
                stateController.delegate = movieView
            }
            
            /*if let favoriteView = tabbarController.viewControllers?[1] as? FavoriteTableViewController {
                favoriteView.stateController = stateController
            }*/
        }
        
        return true
    }


}

