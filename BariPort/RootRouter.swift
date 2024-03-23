//
//  RootRouter.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import UIKit

@MainActor protocol RootRouter{
    var viewController: UIViewController { get }
    
    @MainActor static func assembleModules() -> UIViewController
}

extension RootRouter{
    public func presentAlert(type: Alert.SheetType){
        let alert = type.action()
        viewController.present(alert, animated: true)
    }
    
    public func presentError(error: Error){
        self.presentAlert(type:
                .alert("ERROR", "\(error.localizedDescription)", [.ok({ _ in })]))
    }
    
    public func openURL(url: URL){
        UIApplication.shared.open(url)
    }
}
