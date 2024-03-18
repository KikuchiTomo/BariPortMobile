//
//  Localization.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation

public enum LocalizationString: String{
    case directMessageTabBarItemLabel
    case homeTabBarItemLabel
    case supportTabBarItemLabel
    
    public var localized: String{
        get {
            NSLocalizedString(self.rawValue, tableName: nil, bundle: Bundle.current, comment: self.rawValue)
        }
    }
}
