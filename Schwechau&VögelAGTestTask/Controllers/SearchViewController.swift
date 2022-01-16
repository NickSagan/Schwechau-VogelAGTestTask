//
//  SearchViewController.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import UIKit

class SearchViewCell: UITableViewCell {
    override func awakeFromNib() {super.awakeFromNib()}
    
    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
}

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var bookSearchmanager = BookSearchManager()
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Book Searcher"
        
        searchBar.delegate = self
        bookSearchmanager.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchViewCell", for: indexPath) as! SearchViewCell
        cell.bookTitle.text = books[indexPath.row].title
        cell.bookAuthor.text = books[indexPath.row].author
        
        let thumbnailUrl = URL(string: books[indexPath.row].thumbnail)
        print(thumbnailUrl ?? "thumbnailUrl problem") // HTTPS!!!

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: thumbnailUrl!) else { return }
            DispatchQueue.main.async {
                cell.bookThumbnail.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Book #\(indexPath.row) selected")
    }
}

//MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userRequest = searchBar.text else { return }
        bookSearchmanager.fetch(bookName: userRequest)
    }
}

//MARK: - BookSearchManagerDelegate

extension SearchViewController: BookSearchManagerDelegate {
    
    func updateBooksList(_ bookSearchManager: BookSearchManager, books: [Book]) {
        
        DispatchQueue.main.async {
            self.books = books
            self.tableView.reloadData()
        }
    }
}
