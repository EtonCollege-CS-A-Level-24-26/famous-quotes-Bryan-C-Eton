//
//  FamousQuotesViewModel.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation
import ParseSwift

@Observable
class FamousQuotesViewModel {
    var quotes: [Quote]
    var isShowingAddQuote: Bool
    var newQuoteAuthor: String
    var newQuoteContent: String
    
    init() {
        self.quotes = []
        self.isShowingAddQuote = false
        self.newQuoteAuthor = ""
        self.newQuoteContent = ""
    }
    
    func restoreQuotes() {
        QuoteRepository.shared.getAllQuotes(completion: { quotes in
            self.quotes = quotes
        })
    }
    
    func addNewQuote() {
        let quoteToAdd = Quote(author: newQuoteAuthor, content: newQuoteContent)
        quotes.append(quoteToAdd)
        QuoteRepository.shared.saveQuote(quote: quoteToAdd)
        newQuoteAuthor = ""
        newQuoteContent = ""
        isShowingAddQuote = false
    }
    
    func deleteQuote(quote: Quote) {
        quotes.removeAll { $0.id == quote.id }
        QuoteRepository.shared.deleteQuote(quote: quote) { success in
            if success {
                print("Successfully deleted quote: \(quote.content)")
            } else {
                print("Failed to delete quote.")
            }
        }
    }

    
}
