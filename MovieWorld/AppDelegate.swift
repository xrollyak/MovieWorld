//
//  AppDelegate.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        if let window = self.window {
            MWI.sh.setup(window: window)
        }

        return true
    }
}
