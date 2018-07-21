//
//  ProgressTextManager.swift
//  Book
//
//  Created by Bruno Vieira Bulso on 21/07/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation

class ProgressTextManager {
  
  static let firstSegmentString = ["A1", "A2", "A3"]
  static let secondSegmentStrings = ["B1", "B2", "B3"]
  static let thirdSegmentStrings = ["C1", "C2", "C3"]
  
  static func progressText(currentPage: Int, totalPages: Int) -> String {
    let percentage = (currentPage * 100) / totalPages
    
    if percentage <= 30 {
      return randomValue(from: firstSegmentString)
    }
    
    if percentage <= 70 {
      return randomValue(from: secondSegmentStrings)
    }
    
    if percentage <= 100 {
      return randomValue(from: thirdSegmentStrings)
    }
    return ""
  }
  
  static func randomValue(from list: [String]) -> String {
    let number = Int(arc4random_uniform(UInt32(list.count)))
    return list[number]
  }
}
