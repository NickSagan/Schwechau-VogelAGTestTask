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
        
    }
    
    private func parseJSON() {
        
    }
}
