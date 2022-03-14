//
//  ViewController.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var manager = NetworkManager()
    
    @IBOutlet weak var qouteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.onCompletion = { [weak self] quote in
            guard let self = self else { return }
            self.updateInterface(quote: quote)
            self.setUpImage(quote: quote)
        }
        manager.fetchQuote()
        
    }
    
    func updateInterface(quote: Quote) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.qouteLabel.text = quote.quote
        }
    }
    
    func setUpImage(quote: Quote) {
        quote.image.stringToImage { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        manager.onCompletion = { [weak self] quote in
            self?.updateInterface(quote: quote)
        }
        manager.fetchQuote()
    }
    

}

