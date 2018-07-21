//
//  ProgressTextManager.swift
//  Book
//
//  Created by Bruno Vieira Bulso on 21/07/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation

class ProgressTextManager {
  
  static let firstSegmentString = [StringKeys.startPhrase1, StringKeys.startPhrase2, StringKeys.startPhrase3, StringKeys.startPhrase4]
  static let secondSegmentStrings = [StringKeys.middlePhrase1, StringKeys.middlePhrase2, StringKeys.middlePhrase3, StringKeys.middlePhrase4]
  static let thirdSegmentStrings = [StringKeys.endPhrase1, StringKeys.endPhrase2, StringKeys.endPhrase3, StringKeys.endPhrase4]
  
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
