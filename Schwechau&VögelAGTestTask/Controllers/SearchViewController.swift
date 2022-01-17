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
        
        //MARK: - Display Cached Image Priority (It Improves User Experience While Scrolling)
        
        if let cachedImage = Cache.cache.object(forKey: self.books[indexPath.row].thumbnail as NSString) {
            cell.bookThumbnail.image = cachedImage
            print("Cached image used")
        } else {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: thumbnailUrl!) else { return }
                DispatchQueue.main.async {
                    guard let thumbmailImage = UIImage(data: data) else {return}
                    cell.bookThumbnail.image = thumbmailImage
                    print("Fetched image used")
                    Cache.cache.setObject(thumbmailImage, forKey: self.books[indexPath.row].thumbnail as NSString)
                    print("Image for indexPath.row: \(indexPath.row) cached")
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "bookDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            dvc.book = books[indexPath.row]
        }
    }
    
}

//MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userRequest = searchBar.text else { return }
        bookSearchmanager.fetch(bookName: userRequest)
        searchBar.resignFirstResponder()
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
