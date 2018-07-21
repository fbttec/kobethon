//
//  DefaultManager.swift
//  Book
//
//  Created by Rodrigo Leite on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import Foundation

struct DefaultManager {
    
    static let booksKey = "kBooks"
    
    static let shared = DefaultManager()
    
    func setBooks(books: [Book]?) {
        guard let book: [Book] = books else { return }
        if let data = try? JSONEncoder().encode(book) {
            UserDefaults.standard.set(data, forKey: DefaultManager.booksKey)
        }
    }
    
    func getBooks() -> [Book]? {
        if let data = UserDefaults.standard.data(forKey: DefaultManager.booksKey) {
            return try? JSONDecoder().decode([Book].self, from: data)
        } else {
            return nil
        }
    }
    
}
