//
//  QuoteRepository.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation
import ParseSwift

class QuoteRepository {
    static let shared = QuoteRepository()
    
    private init() {}
    
    func saveQuote(quote: Quote) {
        let quoteDao = QuoteDao(author: quote.author, content: quote.content)
        do {
            try quoteDao.save()
        } catch {
            print("Failing to save quote: \(quote.content)")
        }
    }
    
    func getAllQuotes(completion: @escaping ([Quote]) -> Void) {
        let query = QuoteDao.query().order([.descending("updatedAt")])
        query.find() { response in
            let quotes: [Quote] = (try? response.get())?.compactMap({
                guard let author = $0.author, let content = $0.content else { return nil }
                return Quote(author: author, content: content)
            }) ?? []
            
            completion(quotes)
            
        }
    }
    
    func deleteQuote(quote: Quote, completion: @escaping (Bool) -> Void) {
        let query = QuoteDao.query("objectId" == quote.id)
        query.first { result in
            switch result {
            case .success(let quoteDao):
                quoteDao.delete { deleteResult in
                    switch deleteResult {
                    case .success:
                        print("Successfully deleted quote from cloud: \(quote.content)")
                        completion(true)
                    case .failure(let error):
                        print("Failed to delete quote: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            case .failure(let error):
                print("Error finding quote: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
