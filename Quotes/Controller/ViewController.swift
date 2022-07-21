//
//  ViewController.swift
//  Quotes
//
//  Created by Burak Köse on 5.07.2022.
//

import UIKit
import GhostTypewriter

class ViewController: UIViewController,QuoteManagerDelegate {

    
    @IBOutlet weak var quoteLabel: TypewriterLabel!
    
    @IBOutlet weak var authorLabel: TypewriterLabel!
    
    var quotesManager = QuotesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotesManager.delegate = self
        quotesManager.fetchQuotes()
        
        var GR = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(GR)
       
        
    }
    
    func updateUI(_ data: quoteModel) {
        
        DispatchQueue.main.async { [self] in
            quoteLabel.text = data.quote.uppercased()
            authorLabel.text = "-\(data.author)"
            
            
            startUI()
        }
    }
    
    @objc func tap() {
        quoteLabel.resetTypewritingAnimation()
        authorLabel.resetTypewritingAnimation()
        
        quotesManager.fetchQuotes()
    }
    
    func startUI() {
        
        quoteLabel.typingTimeInterval = 0.03
        quoteLabel.startTypewritingAnimation { [self] in
            authorLabel.typingTimeInterval = 0.03
            authorLabel.startTypewritingAnimation()
        }
    }
    

    

}
