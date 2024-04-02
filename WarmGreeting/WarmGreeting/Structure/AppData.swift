//
//  AppData.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 11.08.2021.
//

import Foundation

struct AppData {

    private let isNewUserKey = "isNewUser"
    private let preloadedDataKey = "didPreloadData"

    private let userDefaults: UserDefaults

    var isNewUser: Bool {
        get {
            return userDefaults.bool(forKey: isNewUserKey)
        }
        set {
            userDefaults.set(newValue, forKey: isNewUserKey)
        }
    }
    var preloadedData: Bool {
        get {
            return userDefaults.bool(forKey: preloadedDataKey)
        }
        set {
            userDefaults.set(newValue, forKey: preloadedDataKey)
        }
    }
    init() {
        self.userDefaults = Foundation.UserDefaults()
        userDefaults.register(defaults: [
                                isNewUserKey: true,
                                preloadedDataKey: false])
    }
}
