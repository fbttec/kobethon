//
//  RegisterBookCollectionViewCell.swift
//  Book
//
//  Created by Rodrigo Leite on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import UIKit

class RegisterBookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RegisterBookCollectionViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configure(book: Book) {
        title.text = book.title
        status.text = "\(book.numberOfPagesRead ?? 0)/\(book.totalOfPages ?? 0)"
        if let readPages = book.numberOfPagesRead,
            let totalPages = book.totalOfPages,
            totalPages > 0 {
            progressView.setProgress(Float(readPages/totalPages), animated: true)
        }
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor(red:0.18, green:0.24, blue:0.31, alpha:0.3).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 15
    }
    
    func generateRandomPastelColor(withMixedColor mixColor: UIColor?) -> UIColor {
        // Randomly generate number in closure
        let randomColorGenerator = { ()-> CGFloat in
            CGFloat(arc4random() % 256 ) / 256
        }
        
        var red: CGFloat = randomColorGenerator()
        var green: CGFloat = randomColorGenerator()
        var blue: CGFloat = randomColorGenerator()
        
        // Mix the color
        if let mixColor = mixColor {
            var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0;
            mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)
            
            red = (red + mixRed) / 2;
            green = (green + mixGreen) / 2;
            blue = (blue + mixBlue) / 2;
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
