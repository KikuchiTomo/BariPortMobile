//
//  LoadingView+Extension.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import UIKit
fileprivate final class LoadingOverLayView: UIView {
  
    public var layouts: [NSLayoutConstraint] = []
    private var indicatorView: UIActivityIndicatorView!
  
    init(frame: CGRect, indicatorStyle: UIActivityIndicatorView.Style) {
        indicatorView = UIActivityIndicatorView(style: indicatorStyle)
        indicatorView.hidesWhenStopped = true
        super.init(frame: frame)
        addSubview(indicatorView)
        indicatorView.center = center
        alpha = 0.4
        backgroundColor = UIColor.init(white: 0.1, alpha: 0.4)
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    func startAnimation() {
        indicatorView.startAnimating()
    }

    func stopAnimation() {
        indicatorView.stopAnimating()
    }
}

// MARK: - UIView Extension
extension UIViewController {
    
    public func showLoading(with indicatorStyle: UIActivityIndicatorView.Style = .large) {
        view.isUserInteractionEnabled = false
        let overLayView = LoadingOverLayView(frame: view.frame, indicatorStyle: indicatorStyle)
        view.addSubview(overLayView)
        overLayView.layouts = [
            overLayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overLayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overLayView.widthAnchor.constraint(equalTo: view.widthAnchor),
            overLayView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        
        NSLayoutConstraint.activate(overLayView.layouts)
        overLayView.startAnimation()
    }

    public func hideLoading() {
        view.isUserInteractionEnabled = true
        view.subviews.forEach { subView in
            if let subView = subView as? LoadingOverLayView {
                subView.stopAnimation()
                NSLayoutConstraint.deactivate(subView.layouts)
                subView.removeFromSuperview()
            }
        }
    }
}


