//
//  Book.swift
//  Book
//
//  Created by Rodrigo Leite on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation

struct Book {
    
    var title: String?
    var numberOfPagesRead: Int?
    var totalOfPages: Int?
    var author: String?
    
    init(title: String, numberOfPagesRead: Int, totalOfPages: Int) {
        self.title = title
        self.numberOfPagesRead = numberOfPagesRead
        self.totalOfPages = totalOfPages
    }
    
}

extension Book: Codable {
    enum CodingKeys: String,CodingKey {
        case title = "title"
        case numberOfPagesRead = "numberOfPagesRead"
        case totalOfPages = "totalOfPages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        let title: String = try container.decode(String.self, forKey: .title) // extracting the data
        let numberOfPagesRead: Int = try container.decode(Int.self, forKey: .numberOfPagesRead) // extracting the data
        let totalOfPages: Int = try container.decode(Int.self, forKey: .totalOfPages) // extracting the data
        self.init(title: title,
                  numberOfPagesRead: numberOfPagesRead,
                  totalOfPages: totalOfPages)
    }
    
    func encode(to encoder: Swift.Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(numberOfPagesRead, forKey: .numberOfPagesRead)
        try container.encode(totalOfPages, forKey: .totalOfPages)
    }
    
}
