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
    
    var landscapeConstraints = [NSLayoutConstraint]()
    var portraitConstraints = [NSLayoutConstraint]()
    
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
        
        portraitConstraints = [
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
        ]
        
        landscapeConstraints = [
            thumbnail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            thumbnail.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            thumbnail.widthAnchor.constraint(equalToConstant: 200),
            thumbnail.heightAnchor.constraint(equalToConstant: 300),
            
            bookTitle.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            bookTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            bookAuthor.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            bookAuthor.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 20),
            
            bookDescription.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            bookDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bookDescription.topAnchor.constraint(equalTo: bookAuthor.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(portraitConstraints)
        
        self.thumbnail = thumbnail
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.bookDescription = bookDescription
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
 
        
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
    
    @objc func orientationChanged(notification: NSNotification) {
         let deviceOrientation = UIApplication.shared.statusBarOrientation

         switch deviceOrientation {
         case .portrait:
             fallthrough
         case .portraitUpsideDown:
             print("Portrait")
             NSLayoutConstraint.deactivate(landscapeConstraints)
             NSLayoutConstraint.activate(portraitConstraints)

         case .landscapeLeft:
             fallthrough
         case .landscapeRight:
             print("landscape")
             NSLayoutConstraint.deactivate(portraitConstraints)
             NSLayoutConstraint.activate(landscapeConstraints)

         case .unknown:
             print("unknown orientation")
         @unknown default:
             print("unknown case in orientation change")
         }
     }
    
}
