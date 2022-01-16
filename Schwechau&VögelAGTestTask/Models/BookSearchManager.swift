//
//  BookSearchManager.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import Foundation

protocol BookSearchManagerDelegate {
    func updateBooksList(_ bookSearchManager: BookSearchManager, books: [Book])
}

struct BookSearchManager {
    
    var delegate: BookSearchManagerDelegate?
    private let googleapisUrl = "https://www.googleapis.com/books/v1/volumes?q="
    
    func fetch(bookName: String) {
        let urlString = googleapisUrl + bookName
        print("Fetching: \(urlString)")
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil { print(error!); return }
            guard let safeData = data else { return }
            guard let books = self.parseJSON(bookData: safeData) else { return }
            self.delegate?.updateBooksList(self, books: books)
        }
        task.resume()
        
        print("Request performed")
    }
    
    private func parseJSON(bookData: Data) -> [Book]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BooksData.self, from: bookData)
            var books = [Book]()
            for item in decodedData.items {
                
                let title = item.volumeInfo.title
                let author = item.volumeInfo.authors?[0] ?? "No author"
                let description = item.volumeInfo.description ?? "No decription"
                let thumbnail = item.volumeInfo.imageLinks.thumbnail.https()

                let book = Book(title: title, author: author, thumbnail: thumbnail, description: description)
                print("JSON parsed: \(books)")
                books.append(book)
            }
            return books
        } catch {
            print(error)
            return nil
        }
    }
}

// to fix googleapis thumbnail links, which are "http"
extension String {
    func https() -> String {
        guard self.hasPrefix("http:") else { return self }
        return String("https:\(self.dropFirst(5))")
    }
}

extension String {
    func noSpaces() -> String {
        return String(self.map {
            $0 == " " ? "+" : $0
        })
    }
}
