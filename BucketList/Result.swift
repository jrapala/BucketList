//
//  Result.swift
//  BucketList
//
//  Created by Juliette Rapala on 12/12/20.
//

import Foundation

// Define structs to store Wikipedia data
// JSON gives query -> pages -> pageid, title, terms
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
