//
//  Books.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import Foundation

struct BooksData: Codable {
    let items: [Item]
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let thumbnail: String
}
