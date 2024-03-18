//
//  UIViewController+Extension.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

extension UIViewController{
    /// 自身をRootにした UINavigationController を返す
    /// - Returns: UINavigationController(rootViewController: self)
    func generatedRootNavigationController() -> UINavigationController{
        let navVC = UINavigationController(rootViewController: self)
        return navVC
    }
    
    /// 自身をRootにした UINavigationController を返す
    /// - Parameter title: NavigationBarのタイトルを設定する
    /// - Returns: UINavigationController(rootVie   Controller: self)
    func generatedRootNavigationController(title: String) -> UINavigationController{
        self.title = title
        let navVC = UINavigationController(rootViewController: self)
        return navVC
    }
}
