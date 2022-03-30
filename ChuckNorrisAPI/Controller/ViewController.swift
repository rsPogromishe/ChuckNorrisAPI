//
//  ViewController.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var manager = NetworkManager()
    private var urlOfImage = ""
    
    @IBOutlet weak var qouteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //#warning("Этот блок кода можно запихнуть в один метод RefreshIndicator, сделай его добавлемым по необходимости, чтобы на каждый контроллер не ставить вью с загрузкой, а добавлять его кодом, когда он станет необходим")
        // Блок кода
        
        manager.onCompletion = { [weak self] Response in
            guard let self = self else { return }
            switch Response {
            case .onSuccess(let quote):
                DispatchQueue.main.async {
                    if self.urlOfImage.elementsEqual(quote.image) {
                        return
                    } else {
                        guard let imageURL = URL(string: quote.image) else { return }
                        guard let imageData = try? Data(contentsOf: imageURL) else { return }
                        self.imageView.image = UIImage(data: imageData)
                        self.urlOfImage = quote.image
                    }
                }
                self.updateInterface(quote: quote)
                DispatchQueue.main.async {
                    RefreshIndicator.stopAnimation()
                }
            case .onError(let error):
                DispatchQueue.main.async {
                    self.errorInterface(error: error.localizedDescription)
                    RefreshIndicator.stopAnimation()
                }
            }
        }
        manager.fetchQuote()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RefreshIndicator.startAnimation(mainView: view)
    }
    
    private func updateInterface(quote: Quote) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.qouteLabel.text = quote.quote
        }
    }
    
    private func errorInterface(error: String) {
        let action = UIAlertController(title: "Ошибка",
                                       message: error,
                                       preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        action.addAction(okAction)
        present(action, animated: true)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.manager.fetchQuote()
        RefreshIndicator.startAnimation(mainView: self.view)
    }
}

