//
//  NotificationManager.swift
//  Book
//
//  Created by Bruno Vieira Bulso on 21/07/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

class NotificationManager {
  
  static let locationManager = CLLocationManager()
  
  static func requestPermissions() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
      if success && error == nil {
        DispatchQueue.main.async {
          requestLocationPermission()
        }
      }
    }
  }
  
  static func requestLocationPermission() {
    
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      // Request when-in-use authorization initially
      locationManager.requestWhenInUseAuthorization()
      break
      
    case .restricted, .denied:
      // Disable location features
      //        disableMyLocationBasedFeatures()
      break
      
    case .authorizedWhenInUse, .authorizedAlways:
      // Enable location features
      //        enableMyWhenInUseFeatures()
      break
    }
  }
  
  static func createTimerNotification(title: String = "Book", text: String, timeInterval: TimeInterval) {
   
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
    let notification = UNMutableNotificationContent()
    notification.body = text
    notification.title = title
    
    // Create the request
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                                        content: notification, trigger: trigger)
    
    // Schedule the request with the system.
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
      if error != nil {
        // Handle any errors.
      }
    }
    
  }
  
  static func createLocationNotification(title: String = "Book", text: String, latitude: Double, longitude: Double) {
    let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Headquarters")
    region.notifyOnEntry = true
    region.notifyOnExit = false
    let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
    let notification = UNMutableNotificationContent()
    notification.body = text
    notification.title = title
    
    // Create the request
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                                        content: notification, trigger: trigger)
    
    // Schedule the request with the system.
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
      if error != nil {
        // Handle any errors.
      }
    }
    
  }
}
