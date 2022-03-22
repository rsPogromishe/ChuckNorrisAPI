//
//  ViewController.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var manager = NetworkManager()
    var refreshIndicator = RefreshIndicator()
    
    @IBOutlet weak var qouteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //#warning("Этот блок кода можно запихнуть в один метод RefreshIndicator, сделай его добавлемым по необходимости, чтобы на каждый контроллер не ставить вью с загрузкой, а добавлять его кодом, когда он станет необходим")
        // Блок кода
        //
        manager.onCompletion = { [weak self] quote in
            guard let self = self else { return }
            guard let imageURL = URL(string: quote.image) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                if self.qouteLabel.text == "" {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
            //#warning("ЗДесь вызываешь главную очередь")
            self.updateInterface(quote: quote)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                //#warning("Внутри этих методов вызываешь главную очередь")
                self.refreshIndicator.stopAnimation()
                self.view.sendSubviewToBack(self.refreshIndicator)
            }
            
        }
        
        manager.onError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.errorInterface(error: error)
                self.refreshIndicator.stopAnimation()
                self.view.sendSubviewToBack(self.refreshIndicator)
            }
        }
        
        
        manager.fetchQuote()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshIndicator.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(refreshIndicator)
        refreshIndicator.startAnimation()
    }
    
    func updateInterface(quote: Quote) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.qouteLabel.text = quote.quote
        }
    }
    
    func errorInterface(error: String) {
        let action = UIAlertController(title: "Ошибка",
                                       message: error,
                                       preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        action.addAction(okAction)
        present(action, animated: true)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
            //#warning("Загрузка цитаты происходит в главной очереди, так же как с картинкой, пока не загрузятся данные, будет полная блокировка интерфейса")
        self.manager.fetchQuote()
        self.refreshIndicator.startAnimation()
    }

}

