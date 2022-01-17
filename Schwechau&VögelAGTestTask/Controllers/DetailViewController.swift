//
//  DetailViewController.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    
    weak var thumbnail: UIImageView!
    weak var bookTitle: UILabel!
    weak var bookAuthor: UILabel!
    weak var bookDescription: UILabel!
    
    override func loadView() {
        super.loadView()
        
        let thumbnail = UIImageView(frame: .zero)
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        let bookTitle = UILabel(frame: .zero)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let bookAuthor = UILabel(frame: .zero)
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        let bookDescription = UILabel(frame: .zero)
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        bookDescription.numberOfLines = 0
        bookDescription.lineBreakMode = .byWordWrapping
        
        self.view.addSubview(thumbnail)
        self.view.addSubview(bookTitle)
        self.view.addSubview(bookAuthor)
        self.view.addSubview(bookDescription)
        
        NSLayoutConstraint.activate([
            thumbnail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            thumbnail.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            thumbnail.widthAnchor.constraint(equalToConstant: 130),
            thumbnail.heightAnchor.constraint(equalToConstant: 200),
            
            bookTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookTitle.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 20),
            
            bookAuthor.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookAuthor.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 20),
            
            bookDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookDescription.topAnchor.constraint(equalTo: bookAuthor.bottomAnchor, constant: 20)
        ])
        
        self.thumbnail = thumbnail
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.bookDescription = bookDescription
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let book = book else { print("Book transfer problem"); return }
        
        bookTitle.text = "Title: " + book.title
        bookAuthor.text = "Author: " + book.author
        bookDescription.text = "Description: " + book.description
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: URL(string: book.thumbnail)!) else { return }
            DispatchQueue.main.async {
                self.thumbnail.image = UIImage(data: data)
            }
        }
    }
}
