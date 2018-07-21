//
//  AppDelegate.swift
//  Book
//
//  Created by Rodrigo Leite on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      let center = UNUserNotificationCenter.current()
      center.delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    // Play sound and show alert to the user
    completionHandler([.alert,.sound])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    
    // Determine the user action
    switch response.actionIdentifier {
    case UNNotificationDismissActionIdentifier:
      print("Dismiss Action")
    case UNNotificationDefaultActionIdentifier:
      print("Default")
    case "Snooze":
      print("Snooze")
    case "Delete":
      print("Delete")
    default:
      print("Unknown action")
    }
    completionHandler()
  }
}

