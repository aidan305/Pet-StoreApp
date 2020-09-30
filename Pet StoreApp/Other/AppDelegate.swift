//
//  AppDelegate.swift
//  Pet StoreApp
//
//  Created by aidan egan on 22/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import UIKit
import Firebase
import Stripe
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Stripe.setDefaultPublishableKey("pk_test_51HCP7yHlie1ShBOFV8irTF3Of1fnoKeXvP3hTPMSKlS5DFi2uX4EUMk37BGZMr2I4atQYlReyvPhrSLhFWTxvKay00FHHAypfj")
        FirebaseApp.configure()
        STPTheme.default().accentColor = UIColor(named: "Primary Green")
                
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

