//
//  BookSearchManager.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import Foundation

struct BookSearchManager {
    
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
            guard let book = self.parseJSON(bookData: safeData) else { return }
            // send books back to VC
        }
        task.resume()
        
        print("Request performed")
    }
    
    private func parseJSON(bookData: Data) -> Book? {
        
    }
}
