//
//  AlertDefinition.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import UIKit
import UIComponents

struct Alert{
    typealias Action = ((_ action: UIAlertAction) -> Void)
    
    enum ActionType{
        case cancel(_ action: Action)
        case ok(_ action: Action)
        
        var style: UIAlertAction.Style{
            switch(self){
            case .cancel(_):
                return .cancel
            case .ok( _):
                return .default
            }
        }
        
        var localized: String{
            switch(self){
            case .cancel(action: _):
                return LocalizationString.alertCancel.localized
            case .ok(action: _):
                return LocalizationString.alertOK.localized
            }
        }
        
        var action: UIAlertAction{
            switch(self){
            case .cancel(let action):
                return .init(title: self.localized, style: self.style, handler: action)
            case .ok(let action):
                return .init(title: self.localized, style: self.style, handler: action)
            }
        }
    }
    
    enum SheetType{
        case bottom(_ title: String, _ message: String, _ selections: [ActionType])
        case alert(_ title: String, _ message: String, _ selections: [ActionType])
        
        func action() -> UIAlertController{
            let alert: UIAlertController
            switch(self){
            case .alert(let title, let message, let selections):
                alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                selections.forEach{ alert.addAction($0.action) }
            case .bottom(let title, let message, let selections):
                alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
                selections.forEach{ alert.addAction( $0.action )}
            }
            
            return alert
        }
    }
}
