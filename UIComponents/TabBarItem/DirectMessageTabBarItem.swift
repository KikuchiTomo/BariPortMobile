//
//  DirectMessageTabBarItem.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

extension UITabBarItem{
    static public func directMessageTabBarItem(tag: Int) -> UITabBarItem{
        .init(
            title: LocalizationString.directMessageTabBarItemLabel.localized,
            image: UIImage.Common.directMessage,
            tag: tag)
    }
}
