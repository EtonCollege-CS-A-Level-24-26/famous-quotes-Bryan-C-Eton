//
//  Quote.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation

struct Quote: Identifiable {
    let author: String
    let content: String

    var id: String {
        "\(author)\(content)"
    }
}
