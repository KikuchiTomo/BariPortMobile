//
//  HomeTabBarItem.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

extension UITabBarItem{
    static public func homeTabBarItem(tag: Int) -> UITabBarItem{
        .init(
            title: LocalizationString.homeTabBarItemLabel.localized,
            image: UIImage.Common.home,
            tag: tag)
    }
}
