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
    @IBOutlet weak var refreshIndicator: RefreshIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshIndicator.isHidden = false
        refreshIndicator.activityIndicator.startAnimating()
        manager.onCompletion = { [weak self] quote in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.updateInterface(quote: quote)
                self.setUpImage(quote: quote)
                self.refreshIndicator.isHidden = true
                self.refreshIndicator.activityIndicator.stopAnimating()
            }
            
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
        manager.stringToImage(url: quote.image) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.manager.fetchQuote()
            self.refreshIndicator.isHidden = false
            self.refreshIndicator.activityIndicator.startAnimating()
        }
        
    }

}

