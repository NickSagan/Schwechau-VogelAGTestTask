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
    }
    
}
