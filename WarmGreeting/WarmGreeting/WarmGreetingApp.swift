//
//  WarmGreetingApp.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 03.08.2021.
//

import SwiftUI
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        preloadData()
        return true
    }
    func preloadData() {
        var appData = AppData()
        if !appData.preloadedData {
            GreetingListViewModel().preloadData()
            appData.preloadedData = true
            
        }
    }
}

@main
struct WarmGreetingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
