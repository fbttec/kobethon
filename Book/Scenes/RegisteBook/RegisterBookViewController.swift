//
//  RegisterBookViewController.swift
//  Book
//
//  Created by Rodrigo Leite on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import UIKit

class RegisterBookViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet var addBarButtonItem: UIBarButtonItem!
    
    var books: [Book]?
    var selectedBook: Book?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        navigationItem.rightBarButtonItem = addBarButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        books = DefaultManager.shared.getBooks()
        collectionView.reloadData()
    }
    
    // MARK: - IBACTION
    
    @IBAction func didTouchAddBook(_ sender: UIBarButtonItem) {
       let alertController = UIAlertController(title: "New Book", message: "Insert a new Book", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Book Title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Total pages"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let titleTextField = alertController.textFields?[0],
                let totalPagesTextField = alertController.textFields?[1] else { return }
            
            let totalPages = Int(totalPagesTextField.text ?? "0")
            let book = Book(title: titleTextField.text!, numberOfPagesRead: 0, totalOfPages: totalPages!)
            if self.books == nil {
                self.books = [book]
            } else {
                self.books?.append(book)
            }
            DefaultManager.shared.setBooks(books: self.books)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let readingVC = segue.destination as? ReadingViewController,
            segue.identifier == "goToReading" {
            readingVC.book = selectedBook
            readingVC.index = selectedIndex
        }
    }
    
}

extension RegisterBookViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBook = books?[indexPath.row]
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "goToReading", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let CellWidth = 80
        let CellCount = 3
        let CellSpacing = 34
        
        let totalCellWidth = CellWidth * CellCount
        let totalSpacingWidth = CellSpacing * (CellCount - 1)
        
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(10, leftInset, 0, rightInset)
    }
    
}

extension RegisterBookViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterBookCollectionViewCell.identifier, for: indexPath)
        if let cell = cell as? RegisterBookCollectionViewCell {
            if let book = books?[indexPath.row] {
                cell.configure(book: book)
            }
        }
        return cell
    }
    
    
}
