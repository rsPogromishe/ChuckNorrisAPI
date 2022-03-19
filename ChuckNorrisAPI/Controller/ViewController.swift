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
        #warning("Этот блок кода можно запихнуть в один метод RefreshIndicator, сделай его добавлемым по необходимости, чтобы на каждый контроллер не ставить вью с загрузкой, а добавлять его кодом, когда он станет необходим")
        // Блок кода
        refreshIndicator.isHidden = false
        refreshIndicator.activityIndicator.startAnimating()
        //
        manager.onCompletion = { [weak self] quote in
            #warning("ЗДесь вызываешь главную очередь")
            DispatchQueue.main.async {
                guard let self = self else { return }
                #warning("Внутри этих методов вызываешь главную очередь")
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
        #warning("Тем самым этот код вызывается в главной очереди, что значит, что пока картинка не будет загружена, интерфейс будет заблокирован")
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
            #warning("Загрузка цитаты происходит в главной очереди, так же как с картинкой, пока не загрузятся данные, будет полная блокировка интерфейса")
            self.manager.fetchQuote()
            self.refreshIndicator.isHidden = false
            self.refreshIndicator.activityIndicator.startAnimating()
        }
        
    }

}

