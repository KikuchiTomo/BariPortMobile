//
//  RootViewController.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/12.
//

import UIKit

final class RootViewController: UIViewController {
    private var contentViewController: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        guard let contentViewController = contentViewController else{
            return
        }
        
        insertContentView(contentViewController)
    }
    
    @MainActor func setContentView(_ viewController: UIViewController){
        self.contentViewController = viewController
        
        if self.isViewLoaded{
            self.insertContentView(self.contentViewController!)
        }
    }
    
    func insertContentView(_ viewController: UIViewController){
        view.insertSubview(viewController.view, at: 0)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
            view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor),
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
        ])
        
        // TODO: Opacity Animation
        viewController.didMove(toParent: self)
    }
    
    static func appRootViewControllerInstance() -> RootViewController?{
        guard let sDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }
        
        return sDelegate.window?.rootViewController as? RootViewController
    }
    
}

