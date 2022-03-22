//
//  RefreshIndicator.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 14.03.2022.
//

import Foundation
import UIKit

class RefreshIndicator: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RefreshIndicator", owner: self, options: nil)
        addSubview(contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
    
    func startAnimation() {
        contentView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimation() {
        contentView.isHidden = true
        activityIndicator.stopAnimating()
    }
}
