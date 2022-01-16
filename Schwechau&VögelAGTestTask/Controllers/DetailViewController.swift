//
//  DetailViewController.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else { return }

        bookTitle.text = "Title: " + book.title
        bookAuthor.text = "Author: " + book.author
        bookDescription.numberOfLines = 0
        bookDescription.lineBreakMode = .byWordWrapping
        bookDescription.text = "Description: " + book.description

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: URL(string: book.thumbnail)!) else { return }
            DispatchQueue.main.async {
                self.thumbnail.image = UIImage(data: data)
            }
        }
    }
}
