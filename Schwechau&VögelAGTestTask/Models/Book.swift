//
//  Book.swift
//  Schwechau&VögelAGTestTask
//
//  Created by Nick Sagan on 16.01.2022.
//

import Foundation
import UIKit

struct Book: Codable {
    var title: String
    var author: String
    var thumbnail: URL
    var description: String
}
