//
//  QuotesManager.swift
//  Quotes
//
//  Created by Burak Köse on 5.07.2022.
//

import Foundation
import UIKit

protocol QuoteManagerDelegate {
    func updateUI(_ data: quoteModel)
}

struct QuotesManager {
    
    let urlString = "https://api.quotable.io/random"
    
    var delegate: QuoteManagerDelegate?
    
    func fetchQuotes() {
        fetchRequest()
    }
    
    private func fetchRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("ops error")
                    return
                }
                
                if let safeData = data {
                    
                    if let quote = parseJson(with: safeData) {
                        delegate?.updateUI(quote)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
   private func parseJson(with data: Data) -> quoteModel? {
        let decoder = JSONDecoder()
       
        do {
            
            let decodedData =  try decoder.decode(quoteData.self, from: data)
            
            let quote = quoteModel(quote: decodedData.content, author: decodedData.author)
            
            return quote
            
            
        }catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}
