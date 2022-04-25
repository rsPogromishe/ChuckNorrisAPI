//
//  RefreshIndicator.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 14.03.2022.
//

import Foundation
import UIKit

class RefreshIndicator: UIView {
    
    static var refreshIndicatorView: UIView?
    
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
    
    class func startAnimation(mainView: UIView) {
        let inView = RefreshIndicator()
        inView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mainView.addSubview(inView)
        inView.isHidden = false
        inView.activityIndicator.startAnimating()
        self.refreshIndicatorView = inView
    }
    
    class func stopAnimation() {
        refreshIndicatorView?.removeFromSuperview()
        refreshIndicatorView = nil
    }
}
