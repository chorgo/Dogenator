//
//  AppDelegate.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            return true
        }
        guard let dogesUrl = URL(string: "http://dogeme.rowanmanning.com/bomb?count=10") else {
            return true
        }
        let rootViewController = DogesFactory().getDoges(with: URLSession.shared, dogesUrl: dogesUrl)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }

}

