//
//  StringExtension.swift
//  Book
//
//  Created by Bruno Vieira Bulso on 21/07/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
}

