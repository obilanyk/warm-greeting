//
//  WarmGreetingApp.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 03.08.2021.
//
// swiftlint:disable trailing_whitespace line_length
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        preloadData()
        return true
    }
    func preloadData() {
        var appData = AppData()
        if !appData.preloadedData {
//            Utils().evaluateProblem(problemNumber: 1) {
//                PersistentController.shared.jsonTwo { greeting in
//                    PersistentController.shared.createGreeting(with: greeting)
//                    // Time to evaluate problem 1: 0.108325111 seconds
//                }
//            }
            Utils().evaluateProblem(problemNumber: 2) {
                PersistentController.shared.jsonTwo { greeting in
                    PersistentController.shared.createInBackround(with: greeting)
                    // Time to evaluate problem 2: 0.013331933 seconds
                }
            }
            appData.preloadedData = true
            
        }
    }
}

@main
struct WarmGreetingApp: App {
    let persistenceController = PersistentController.shared
    @Environment(\.scenePhase) var scenePhase

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) {(newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Default")
            }
        }
    }
}
