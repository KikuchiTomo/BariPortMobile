//
//  SupportTabBarItem.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

extension UITabBarItem{
    static public func supportTabBarItem(tag: Int) -> UITabBarItem{
        .init(
            title: LocalizationString.supportTabBarItemLabel.localized,
            image: UIImage.Common.floatRing,
            tag: tag)
    }
}
